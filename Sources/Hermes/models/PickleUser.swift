//
// Created by Hugo Medina on 2019-04-01.
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL
import GaiaCodables

class PickleUser : Table {
    static let tableName = "pickleuser"

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

    public static func getCreateTable() -> String {
        return """
               CREATE TABLE IF NOT EXISTS \(tableName) (
                   id UUID NOT NULL PRIMARY KEY,
                   email VARCHAR(320) DEFAULT NULL,
                   nickname VARCHAR(50) DEFAULT NULL,
                   password VARCHAR(60) DEFAULT NULL,
                   level SMALLINT DEFAULT 1,
                   elo UUID UNIQUE
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
}
