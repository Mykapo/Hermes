//
// Created by Hugo Medina on 2019-04-02.
//

import Foundation
import GaiaCodables

class PickleMission {
    var elo = GaiaCodables.Elo(energy: 0, waste: 0, food: 0)
    var id: UUID = UUID()
    var duration: Int? = nil
    var description: String? = nil
    var image: String? = nil
    var mainSubject: MissionCategory? = nil
    var explanations: String? = nil
    var tips = [String]()

    static let tableName = "mission"

    init?(from mission: Mission) {
        guard let mid = mission.id else {
            print("No id for this mission")
            return
        }

        id = mid
        duration = mission.duration
        description = mission.description
        image = mission.image
        if let c = mission.mainSubject {
            mainSubject = MissionCategory(rawValue: c)
        }
        explanations = mission.explanations
        tips = mission.tips ?? []
    }

    init() {
        id = UUID()
    }

    init?(from queryResult: [String: Any?]) {
        guard let qid = queryResult["id"] as? String,
              let mid = UUID(uuidString: qid) else {
            return
        }

        id = mid
        duration = queryResult["duration"] as? Int
        description = queryResult["description"] as? String
        image = queryResult["image"] as? String
        if let c = queryResult["mainSubject"] as? String {
            mainSubject = MissionCategory(rawValue: c)
        }
        explanations = queryResult["explanations"] as? String
//        tips = queryResult["tips"] as? [String]
        tips = []
    }

    private static func getCreateTable() -> String {
        return """
            CREATE TABLE IF NOT EXISTS \(tableName) (
               id UUID NOT NULL PRIMARY KEY,
               duration SMALLINT,
               description TEXT,
               image VARCHAR(100),
               mainSubject VARCHAR(15),
               explanations TEXT
            );
            """
    }

    public static func createTable() throws {
        guard let connexion = Connexion.shared else {
            throw ConnexionImpossible()
        }

        connexion.exec(query: getCreateTable())
    }

    public static func fetchAll(_ fields: [String]? = nil, completion: @escaping ([PickleMission]?, Error?) -> Void)  {
        var results = [PickleMission]()

        guard let connexion = Connexion.shared else {
            print("no connexion")
            completion(nil, ConnexionImpossible())
            return
        }

        var fieldsToString = "*"
        if nil != fields {
            fieldsToString = "'\(fields!.joined(separator: "', '"))'"
        }

        let query = "SELECT \(fieldsToString) FROM \(tableName);"
        connexion.exec(query: query) {
            rows, error in

            for row in rows {
                if let element = PickleMission(from: row) {
                    results.append(element)
                }
            }

            completion(results, nil)
        }
    }

    /**
    Kind of useless at first sight but might be usefull to use references instead of objects in backend
    */
    public func toCodable() -> Codable {
        return Mission(
            id: id,
            duration: duration,
            description: description,
            image: image,
            mainSubject: mainSubject?.rawValue,
            explanations: explanations,
            tips: tips,
            elo: elo
        )
    }

}
