import Foundation
import Kitura
import KituraCompression
import KituraCORS
import HeliumLogger
import SwiftKuery
import SwiftKueryPostgreSQL

import GaiaCodables

HeliumLogger.use()

Connexion.setup(context: DbContext(dbname: "ceres_test", user: "admin", pass: "ceres", port: 5432, host: "localhost", options: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50), timeout: 60))

let router = Router()
let cors = CORS(options: Options(allowedOrigin: .all, allowedHeaders: ["Content-Type"]))

router.all(middleware: [cors, BodyParser(), Compression()])

router.get("/") {
    request, response, next in

    let u = defaultUser

    do {
        try response.send(u).end()
        next()
    } catch let e {
        print(e.localizedDescription)
        response.status(.internalServerError)
        next()
    }
}

Missions.setUpRoutes(with: router)

Kitura.addHTTPServer(onPort: 80, with: router)
Kitura.run()
