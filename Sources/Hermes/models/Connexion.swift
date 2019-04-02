//
// Created by Hugo Medina on 2019-04-01.
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL
import HeliumLogger
import GaiaCodables

struct DbContext {
    let dbname: String
    let user: String
    let pass: String
    let port: Int32
    let host: String
    let options: ConnectionPoolOptions
    let timeout: Int

    init(
        dbname: String,
        user: String,
        pass: String,
        port: Int32,
        host: String,
        options: ConnectionPoolOptions,
        timeout: Int = 60
    ) {
        self.dbname = dbname
        self.user = user
        self.pass = pass
        self.port = port
        self.host = host
        self.options = options
        self.timeout = timeout
    }
}

class Connexion {
    let psqlConnection: PostgreSQLConnection
    public let pool: ConnectionPool? = nil
    public static var shared: Connexion? = nil
    var semaphores = [String:DispatchSemaphore]()

    public static func setup(context: DbContext) {
        shared = Connexion(context: context)
    }

    private init(context: DbContext) {
        psqlConnection = PostgreSQLConnection(host: context.host, port: context.port, options: [
            .databaseName(context.dbname),
            .userName(context.user),
            .password(context.pass),
            .connectionTimeout(context.timeout)
        ])
//        pool = PostgreSQLConnection.createPool(host: context.host, port: context.port, options: [
//            .databaseName(context.dbname),
//            .userName(context.user),
//            .password(context.pass),
//            .connectionTimeout(context.timeout)
//        ], poolOptions: ConnectionPoolOptions(initialCapacity: 1))
    }
    
    public func exec(query: String) {
        psqlConnection.connect() {
            result in

            guard result.success else {
                print("Failed to connect to db")

                return
            }
        }

        psqlConnection.execute(query) {
            dbResponse in

            let successMessage = dbResponse.success ? "did succeed" : "did fail"
            print("Query : \(query) \(successMessage)")
        }

        psqlConnection.closeConnection()
    }

    public func execute(query: String, params: [String: Any?], completion: @escaping (([[String: Any?]]?, Error?)) -> ()) {
        psqlConnection.connect() {
            result in

            guard result.success else {
                print("Failed to connect to db")

                return
            }
        }

        psqlConnection.execute(query, parameters: params) {
            results in

            results.asRows() {
                result in

                completion(result)
            }
        }

        psqlConnection.closeConnection()
    }

    func getSemaphore() -> DispatchSemaphore {
        var queue = DispatchQueue.main.label
        if let currentDispatch = OperationQueue.current?.underlyingQueue { queue = currentDispatch.label }
        var sem = semaphores[queue]
        if sem == nil {
            #if os(Linux)
            sem = DispatchSemaphore(value: Int(random()))
            #else
            sem = DispatchSemaphore(value: Int(arc4random()))
            #endif
            semaphores[queue] = sem
        }

        return sem!
    }

}

struct ConnexionImpossible: Error {
    let localizedDescription = "Connexion impossible"
}

extension Table {
    static func checkIfExists(in connexion: Connexion) -> Bool {
        return false
    }
}
