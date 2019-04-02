//
// Created by Hugo Medina on 2019-04-02.
//

import Foundation
import Kitura
import GaiaCodables

class Missions {
    static func handleMissionEnding(uid: UUID, mid: UUID,  result: EloCalculator.Result) {

        let mission = Temp.getMissions(2).filter { mission in mission.id == mid }.first!
        EloCalculator.updateElos(of: &defaultUser, against: mission, result: result, for: EloCalculator.PickleField(rawValue: mission.mainSubject!)!)
    }

    public static func setUpRoutes(with router: Router) {
        router.get("/:user_id/missions/new") {
            request, response, next in

            guard let requestUserId = request.parameters["user_id"],
                  let /*userId*/ _ = UUID(uuidString: requestUserId) else {
                response.status(.badRequest)
                return
            }

            var user = defaultUser
            user.missions.append(contentsOf: Temp.getMissions(2))

            do {
                try response.send(user).end()
            } catch let e {
                print(e.localizedDescription)
                response.status(.internalServerError)
            }

            next()
        }

        router.get("/:user_id/:mission_id/success") {
            request, response, next in

            guard let requestUserId = request.parameters["user_id"],
                  let userId = UUID(uuidString: requestUserId),
                  let rmissionId = request.parameters["mission_id"],
                  let missionId = UUID(uuidString: rmissionId)
                    else {
                response.status(.badRequest)
                return
            }

            handleMissionEnding(uid: userId, mid: missionId, result: .victory)

            do {
                try response.send(defaultUser).end()
            } catch let e {
                print(e.localizedDescription)
                response.status(.internalServerError)
            }
            next()
        }

        router.get("/:user_id/:mission_id/failure") {
            request, response, next in

            guard let requestUserId = request.parameters["user_id"],
                  let userId = UUID(uuidString: requestUserId),
                  let rmissionId = request.parameters["mission_id"],
                  let missionId = UUID(uuidString: rmissionId)
                    else {
                response.status(.badRequest)
                return
            }

            handleMissionEnding(uid: userId, mid: missionId, result: .defeat)

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
