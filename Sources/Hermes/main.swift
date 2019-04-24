import Foundation
import Kitura
import HeliumLogger
import SwiftKuery
import SwiftKueryPostgreSQL
import GaiaCodables

HeliumLogger.use()

// Waiting for database to be built...
// @ToDo find a smart way to execute this code when database is built
sleep(8)

Connexion.setup(context: DbContext(dbname: "ceres_test", user: "admin", pass: "ceres", port: 5432, host: "postgres", options: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50), timeout: 60))

do {
    try PickleMission.createTable()
    // @ToDo execute that synchronously seems to be a smart option :)
    sleep(1)
    try PickleUser.createTable()
} catch let e {
    print(e.localizedDescription)
    exit(1)
}

let router = Router()
AppRouter.setup(router: router)
AppRouter.createRoutes(with: router)

Kitura.addHTTPServer(onPort: 80, with: router)
Kitura.run()
