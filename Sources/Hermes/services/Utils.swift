//
// Created by Hugo Medina on 2019-04-02.
//

import Foundation
import GaiaCodables

struct ConnexionImpossible: Error {
    let localizedDescription = "Connexion impossible"
}

infix operator ==
extension Mission {
    public static func == (_ lhs: Mission, _ rhs: Mission) -> Bool {
        return lhs.id == rhs.id
    }
}
extension User {
    public static func == (_ lhs: User, _ rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
