//
// Created by Hugo Medina on 2019-04-24.
//

import Foundation

class MissionsController {
    func handleMissionEnding(uid: UUID, mid: UUID,  result: EloCalculator.Result) {

        let mission = Temp.getMissions(2).filter { mission in mission.id == mid }.first!
        EloCalculator.updateElos(of: &defaultUser, against: mission, result: result, for: EloCalculator.PickleField(rawValue: mission.mainSubject!)!)
    }
}
