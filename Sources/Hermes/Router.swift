//
// Created by Hugo Medina on 2019-04-24.
//

import Foundation
import Kitura
import KituraCompression
import KituraCORS
import GaiaCodables

class AppRouter {
    public static func setup(router: Router) {
        let cors = CORS(options: Options(allowedOrigin: .all, allowedHeaders: ["Content-Type"]))
        router.all(middleware: [cors, BodyParser(), Compression(), StaticFileServer()])
    }

    public static func createRoutes(with router: Router) {
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

        router.get("/test") {
            _, response, next in

            PickleMission.fetchAll() {
                missions, error in

                guard let missions = missions else {
                    print(error?.localizedDescription ?? "WTF error")
                    response.status(.internalServerError)
                    next()

                    return
                }

                var data = [Mission]()
                for mission in missions {
                    data.append(mission.toCodable() as! Mission)
                }

                struct Test : Codable {
                    let Ok = "did Complete"
                    let missions : [Mission]
                }

                do {
                    try response.send(Test(missions: data)).end()
                } catch let e {
                    print(e.localizedDescription)
                    response.status(.internalServerError)
                }

                next()
            }
        }

        createUserRoutes(with: router)
        createMissionsRoutes(with: router)
    }

    static func createUserRoutes(with router: Router) {
        let controller = UserController()

        router.get("/user/new") {
            request, response, next in

//            let user = User(id: UUID(),
//                    email: nil,
//                    nickname: nil,
//                    password: nil,
//                    missions: [],
//                    level: .jeunepousse,
//                    elo: Elo(energy: 0, waste: 0, food: 0)
//            )

            let user = PickleUser()
            user.id = UUID()
            user.save()

            do {
                try response.send(User(id: user.id, email: nil, nickname: nil, password: nil, missions: nil, level: .jeunepousse, elo: Elo(energy: 0, waste: 0, food: 0))).end()
                next()
            } catch let e {
                print(e.localizedDescription)
                response.status(.internalServerError)
                next()
            }
        }

        router.get("/user/:id") {
            request, response, next in

            print("in here")

            guard let idString = request.parameters["id"],
                  let id = UUID(uuidString: idString) else {

                response.status(.badRequest)
                return
            }

            PickleUser.fetch(id: id) {
                user, e in

                guard nil == e else {
                    print(e?.localizedDescription)

                    return
                }

                guard let user = user else {
                    _ = try? response.status(.notFound).end()
                    next()
                    return
                }

                do {
                    let codableUser = user.toCodable() as! User
                    try response.send(codableUser).end()
                    next()
                } catch let err {
                    print(err.localizedDescription)
                    _ = try? response.status(.internalServerError).end()
                    next()
                }
            }
        }

    }

    static func createMissionsRoutes(with router: Router) {
        let controller = MissionsController()

        router.get("/:user_id/missions/new/:n") {
            request, response, next in

            guard let requestUserId = request.parameters["user_id"],
                  let /*userId*/ _ = UUID(uuidString: requestUserId),
                  let nn = request.parameters["n"],
                  let n = Int(nn) else {
                response.status(.badRequest)
                return
            }

            var user = defaultUser
            user.missions.append(contentsOf: Temp.getMissions(n))

            do {
                try response.send(user).end()
            } catch let e {
                print(e.localizedDescription)
                response.status(.internalServerError)
            }

            next()
        }

        router.get("/:user_id/:mission_id/:result") {
            request, response, next in

            guard let resultString = request.parameters["result"],
                  let result = EloCalculator.Result(rawValue: resultString) else {
                next()
                return
            }

            guard let requestUserId = request.parameters["user_id"],
                  let userId = UUID(uuidString: requestUserId),
                  let rmissionId = request.parameters["mission_id"],
                  let missionId = UUID(uuidString: rmissionId)
                    else {
                response.status(.badRequest)
                return
            }

            controller.handleMissionEnding(uid: userId, mid: missionId, result: result)

            do {
                try response.send(defaultUser).end()
            } catch let e {
                print(e.localizedDescription)
                response.status(.internalServerError)
            }
            next()
        }
    }
}
