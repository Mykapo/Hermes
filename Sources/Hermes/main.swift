import Foundation
import Kitura
import HeliumLogger
import SwiftKuery
import SwiftKueryPostgreSQL
import GaiaCodables

HeliumLogger.use()

guard let dbname = ProcessInfo.processInfo.environment["POSTGRES_DB"],
      let dbuser = ProcessInfo.processInfo.environment["POSTGRES_USER"],
      let dbpass = ProcessInfo.processInfo.environment["POSTGRES_PASSWORD"],
      let dbhost = ProcessInfo.processInfo.environment["POSTGRES_HOST"],
      let dbportString = ProcessInfo.processInfo.environment["POSTGRES_PORT"],
      let dbport = Int32(dbportString)
        else {
    print("Database information wasn't found in env")
    exit(1)
}

// Waiting for database to be built...
// @ToDo find a smart way to execute this code when database is built
sleep(8)

Connexion.setup(context: DbContext(
        dbname: dbname,
        user: dbuser,
        pass: dbpass,
        port: dbport,
        host: dbhost,
        options: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50),
        timeout: 60)
)

do {
    try PickleMission.createTable()
    // @ToDo execute that synchronously seems to be a smart option :)
    sleep(1)
    try PickleUser.createTable()
    sleep(1)
    try RelTables.createTables()
} catch let e {
    print(e.localizedDescription)
    exit(1)
}

let router = Router()
AppRouter.setup(router: router)
AppRouter.createRoutes(with: router)

Kitura.addHTTPServer(onPort: 80, with: router)
Kitura.run()
