//
// Created by Hugo Medina on 2019-04-01.
//

import Foundation
import GaiaCodables

typealias MissionCategory = EloCalculator.PickleField

class EloCalculator {
    enum Result: String {
        case victory
        case defeat
        case draw
    }

    enum PickleField : String {
        case energy, waste, food
    }

    static let eloConst = 400.0

    private static func uniformizeDifference(_ difference: Double) -> Double {
        var d: Double = difference
        if difference > 400 {
            d = 400
        } else if difference < -400 {
            d = -400
        }

        return d
    }

    static func getProbabilityOfWinning(for playerElo: Int, against questElo: Int) -> Double {
        // For possibility of constant improvement even when 5000 facing 1, use uniformizeDiffence(Double(exactly: playerElo - questElo)!) -> Double
        let difference = Double(exactly: playerElo - questElo)!
        let denominator = 1 + pow(10, ((difference / eloConst) * -1.0))

        return 1.0 / denominator
    }

    static func generateK(for elo: Int) -> Double {
        var k : Double = 10.0
        if elo < 2000 {
            k = 20.0
        } else if elo < 1000 {
            k = 40.0
        }

        return k
    }

    static func generateNewElo(for playerElo: Int, against questElo: Int, result r: Double) -> Int {
        let k = generateK(for: playerElo)
        let d = getProbabilityOfWinning(for: playerElo, against: questElo)
        let e = Double(exactly: playerElo)!
        var newElo = e + k * (r - d)
        if newElo < 0.0 {
            newElo = 0.0
        }

        return Int(round(newElo))
    }

    static func updateElos(of player: inout User, against mission: Mission, result: EloCalculator.Result, for field: EloCalculator.PickleField) {
        let r: Double
        switch result {
        case .defeat:
            r = 0.0
        case .draw:
            r = 0.5
        case .victory:
            r = 1.0
        }

        switch field {
        case .energy:
            player.elo.energy = generateNewElo(for: player.elo.energy, against: mission.elo.energy, result: r)
        case .waste:
            player.elo.waste = generateNewElo(for: player.elo.waste, against: mission.elo.waste, result: r)
        case .food:
            player.elo.food = generateNewElo(for: player.elo.food, against: mission.elo.food, result: r)
        }
    }
}

