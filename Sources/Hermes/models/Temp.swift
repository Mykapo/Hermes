//
// Created by Hugo Medina on 2019-04-02.
//

import Foundation
import GaiaCodables

var defaultUser = User(
        id: UUID(uuidString: "2deb7967-0148-48c7-be5d-191e1f5cd42d"),
        email: nil,
        nickname: nil,
        password: nil,
        missions: [],
        level: .jeunepousse,
        elo: Elo(
                energy: 0,
                waste: 0,
                food: 0
        )
)

class Temp {
    static let m1 = Mission(
            id: UUID(uuidString: "99c2bb2a-be24-46c1-ad55-16f6150cd3c9"),
            duration: "1 jour",
            description: "Supprimer ses vieux mails",
            image: nil,
            mainSubject: "energy",
            explanations: "La pollution numérique émet autant de gaz à effet de serre que l'aviation civile ! Si 1 000 personnes effacent 160 e-mails, on économise l'équivalent en émission de CO2 d'un aller-retour Paris/New York.",
            tips: [
                "Supprimez vos anciens mails avec photos ou vidéos une fois les fichiers récupérés.",
                "Désabonnez-vous des newsletters qui ne vous intéressent plus.",
                "Utilisez CleanFox pour faciliter cette démarche ! (https://www.cleanfox.io/fr-FR/)",
            ],
            elo: Elo(energy: 10, waste: 0, food: 0)
    )

    static let m2 = Mission(
            id: UUID(uuidString: "d5217bd0-ce0e-4214-a0ee-d483ba8b71b8"),
            duration: "3 jours",
            description: "Mettre ses sites fréquents en favoris",
            image: nil,
            mainSubject: "energy",
            explanations: "Chaque requête sur google émet 7g de CO2 soit l'équivalent d'1km en voiture pour 30 recherches, et on fait en moyenne 40 000 requêtes chaque seconde, soit 100 milliards par mois. L'impact environnemental du numérique est gigantesque et il continue à augmenter.",
            tips: [
                "Utiliser le moins possible les moteurs de recherches avec des raccourcis",
                "Utiliser raindrop.io pour centraliser tous ses favoris (tous les devices)",
                "Les ajouter au fur et à mesure, pas la peine de le faire d'un seul coup",
            ],
            elo: Elo(energy: 10, waste: 0, food: 0)
    )

    static let m3 = Mission(
            id: UUID(uuidString: "c2151afe-5061-4359-bcb7-9f95a75f421a"),
            duration: nil,
            description: "Acheter une gourde réutilisable",
            image: nil,
            mainSubject: "waste",
            explanations: "Environ 10 millions de tonnes de plastique sont produite chaque seconde dans le monde. Entre 8 et 12 millions de tonnes finissent dans nos océans.",
            tips: [
                "Trouvez votre gourde idéale sur https://www.sans-bpa.com/903-gourdes-inox avec des marques comme Qwetch ou Klean Kanteen.",
                "Privilégiez l'inox car il résiste au froid et à la chaleur... et ça évite le plastique !"
            ],
            elo: Elo(energy: 0, waste: 20, food: 0)
    )

    static func getMissions(_ n: Int) -> [Mission] {

        return [m1, m2, m3]
    }
}
