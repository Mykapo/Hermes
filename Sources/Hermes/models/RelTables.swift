//
// Created by Hugo Medina on 2019-04-04.
//

import Foundation

class RelTables {
    static let tipsTableName = "tips"
    static let eloTableName = "elo"

    private static func getRelCreateTables() -> [String] {
        return [
            """
            CREATE TABLE IF NOT EXISTS \(tipsTableName) (
                value TEXT NOT NULL,
                mission UUID NOT NULL REFERENCES \(PickleMission.tableName)(id)
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS \(eloTableName) (
                waste SMALLINT,
                energy SMALLINT,
                food SMALLINT,
                mission UUID NOT NULL REFERENCES \(PickleMission.tableName)(id),
                pickleuser UUID NOT NULL REFERENCES \(PickleUser.tableName)(id)
            ); 
            """
        ]
    }

    static func createTables() throws {
        guard let connexion = Connexion.shared else {
            throw ConnexionImpossible()
        }

        for query in getRelCreateTables() {
            connexion.exec(query: query)
            sleep(1)
        }
    }
}
