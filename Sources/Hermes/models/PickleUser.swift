//
// Created by Hugo Medina on 2019-04-01.
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL
import GaiaCodables

class PickleUser : Table {
    static let tableName = "user"
    let id = Column("id", UUID.self, primaryKey: true)
    let email = Column("email", String.self, length: 254, autoIncrement: false, primaryKey: false, notNull: true, unique: true, defaultValue: nil, check: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\\\.[A-Za-z]{2,64}")
    let nickname = Column("nickname", String.self, length: 100, autoIncrement: false, primaryKey: false, notNull: true, unique: true)
    // @Todo implement password necessity
    let password = Column("password", String.self, length: nil)
    let salt = Column("salt", String.self, length: 32)
    var missions = [Mission]()
    let level = Level.jeunepousse
    var elo = Elo(energy: 0, waste: 0, food: 0)



    public func toCodable() -> Codable {
        return User(
            id: nil,
            email: nil,
            nickname: nil,
            password: nil,
            missions: nil,
            level: .jeunepousse,
            elo: Elo(energy: 0, waste: 0, food: 0)
        )
    }

    public static func createTableIfNeeded() throws {
        guard let connexion = Connexion.shared else {
            throw ConnexionImpossible()
        }

        connexion.exec(query: """
                              CREATE TABLE IF NOT EXISTS \(tableName) (
                                  id
                              );
                              """)
    }
}
