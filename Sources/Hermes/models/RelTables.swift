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
            CREATE TABLE IF NOT EXISTS '\(tipsTableName)' (
                value TEXT NOT NULL,
                mission UUID NOT NULL INDEX
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS '\(eloTableName)' (
                waste SMALLINT,
                energy SMALLINT,
                food SMALLINT,
                mission UUID NOT NULL INDEX,
                user UUID NOT NULL INDEX
            ); 
            """
        ]
    }
}
