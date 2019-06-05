//
// Created by Hugo Medina on 2019-04-01.
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL
import GaiaCodables

class PickleUser : Table {
    static let tableName = "pickleuser"
    var tablename: String {
        get { return PickleUser.tableName }
    }

    var id: UUID? = nil
    var email: String? = nil
    var nickname: String? = nil
    var password: String? = nil
    var missions: [PickleMission]? = nil
    var level: Level = .jeunepousse
    var elo: Elo = Elo(energy: 0, waste: 0, food: 0)

    public func toCodable() -> Codable {
        var missionsJsonifiable = [Codable]()

        if let ms = missions {
            for m in ms {
                missionsJsonifiable.append(m.toCodable())
            }
        }

        return User(
            id: id,
            email: email,
            nickname: nickname,
            password: password,
            missions: (missionsJsonifiable as! [Mission]),
            level: .jeunepousse,
            elo: Elo(energy: 0, waste: 0, food: 0)
        )
    }

    public static func getCreateTable() -> String {
        return """
               CREATE TABLE IF NOT EXISTS \(tableName) (
                   id UUID NOT NULL PRIMARY KEY,
                   email VARCHAR(320) DEFAULT NULL,
                   nickname VARCHAR(50) DEFAULT NULL,
                   password VARCHAR(60) DEFAULT NULL,
                   level SMALLINT DEFAULT 0,
                   elo JSONB
               );
               """
        // REFERENCES elo ON id
    }

    public static func createTable() throws {
        guard let connexion = Connexion.shared else {
            throw ConnexionImpossible()
        }

        connexion.exec(query: getCreateTable())
    }

    func save() {
        guard let db = Connexion.shared, let id = id else { return }
        do {
            let j = try JSONEncoder().encode(elo)
            let eloString = String(data: j, encoding: .utf8)

            guard nil != eloString else { return }
            let query = """
                        INSERT INTO \(tablename)
                            (id, email, nickname, password, level, elo)
                        VALUES
                            ('\(id.uuidString)'::uuid, '\(email ?? "")', '\(nickname ?? "")', '\(password ?? "")', \(level.rawValue), '\(eloString!)'::json)
                        ON CONFLICT (id) DO UPDATE SET
                            email = EXCLUDED.email,
                            nickname = EXCLUDED.nickname,
                            password = EXCLUDED.password,
                            level = EXCLUDED.level,
                            elo = EXCLUDED.elo
                        ;
                        """

            db.exec(query: query) {
                results, error in

                if let error = error {
                    print(error)
                }
            }
        } catch (let e) {
            print(e.localizedDescription)
            return
        }
    }

    public static func fetch(id: UUID, partial: Bool = true, _ completion: @escaping (PickleUser?, Error?) -> Void)
    {
        guard let db = Connexion.shared else { return }
        db.exec(query: "SELECT * FROM \(tableName) WHERE id = '\(id.uuidString)'::uuid") {
            results, error in

            guard let result = results.first, nil == error else {
                completion(nil, error)
                return
            }

            let user = PickleUser()
            if let idString = result["id"] as? String,
               idString == id.uuidString,
               let id = UUID(uuidString: idString) {
                user.id = id
                if let nick = result["nickname"] as? String {
                    user.nickname = nick
                }
                if let rawlevel = result["level"] as? Int,
                   let level = Level(rawValue: rawlevel) {
                    user.level = level
                }
                if let rawElo = result["elo"] as? Data,
                   let elo = try? JSONDecoder().decode(Elo.self, from: rawElo) {
                    print("Hello !!!")
                    user.elo = elo
                }
                if !partial {
                    if let email = result["email"] as? String {
                        user.email = email
                    }
                }

                completion(user, nil)
            }

            completion(nil, nil)
        }
    }
}
