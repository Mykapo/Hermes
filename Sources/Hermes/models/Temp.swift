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
            duration: 0,
            description: "Supprimer ses vieux mails",
            image: "supprimer-email.jpg",
            mainSubject: "energy",
            explanations: "La pollution numérique émet autant de gaz à effet de serre que l'aviation civile ! Si 1 000 personnes effacent 160 e-mails, on économise l'équivalent en émission de CO2 d'un aller-retour Paris/New York.",
            tips: [
                "Supprimez vos anciens mails avec photos ou vidéos une fois les fichiers récupérés.",
                "Désabonnez-vous des newsletters qui ne vous intéressent plus.",
                "Utilisez CleanFox pour faciliter cette démarche ! (https://www.cleanfox.io/fr-FR/)",
            ],
            elo: Elo(energy: 10, waste: 0, food: 0),
            results: "0,004kg de CO2 par jour",
            bgColor: .green
    )

    static let m2 = Mission(
            id: UUID(uuidString: "d5217bd0-ce0e-4214-a0ee-d483ba8b71b8"),
            duration: 3,
            description: "Mettre ses sites fréquents en favoris",
            image: "sites-favoris.jpg",
            mainSubject: "energy",
            explanations: "Chaque requête sur google émet 7g de CO2 soit l'équivalent d'1km en voiture pour 30 recherches, et on fait en moyenne 40 000 requêtes chaque seconde, soit 100 milliards par mois. L'impact environnemental du numérique est gigantesque et il continue à augmenter.",
            tips: [
                "Utiliser le moins possible les moteurs de recherches avec des raccourcis",
                "Utiliser raindrop.io pour centraliser tous ses favoris (tous les devices)",
                "Les ajouter au fur et à mesure, pas la peine de le faire d'un seul coup",
            ],
            elo: Elo(energy: 10, waste: 0, food: 0),
            results: "0,0036kg de CO2 par jour",
            bgColor: .purple
    )

    static let m3 = Mission(
            id: UUID(uuidString: "c2151afe-5061-4359-bcb7-9f95a75f421a"),
            duration: 0,
            description: "Acheter une gourde réutilisable",
            image: "bouteille-reutilisable.jpg",
            mainSubject: "waste",
            explanations: "Environ 10 millions de tonnes de plastique sont produite chaque seconde dans le monde. Entre 8 et 12 millions de tonnes finissent dans nos océans.",
            tips: [
                "Trouvez votre gourde idéale sur https://www.sans-bpa.com/903-gourdes-inox avec des marques comme Qwetch ou Klean Kanteen.",
                "Privilégiez l'inox car il résiste au froid et à la chaleur... et ça évite le plastique !"
            ],
            elo: Elo(energy: 0, waste: 20, food: 0),
            results: "0,033kg de déchet par jour",
            bgColor: .purple
    )

    static let m4 = Mission(id: UUID(uuidString: "5b2b5087-7db2-4fe0-87ff-eda0e2d1e958"), 
            duration: 0,
            description: "Remplacer les ampoules épuisées par des basses consommation", 
            image: "ampoules-basse-conso.jpg", 
            mainSubject: "energy", 
            explanations: "En France, on compte en moyennes près de 25 points lumineux par logement, et l'éclairage est responsable d'environ 10% de la facture d'électricité. Éteindre la lumière en quittant une pièce, on y pense presque tous, mais diminuer sa consommation d'électricité passe également par le choix de son équipement.\nDes lampes LED ou Fluocompactes remplacent les ampoules halogènes, qui sont amenées à disparaître. Une bonne chose, sachant que les ampoules basse consommation peuvent consommer jusqu'à 10 fois moins de courant pour une même luminosité !\nPetit plus : les ampoules peuvent être recyclées en point de collecte en magasin ou en déchetterie.", 
            tips: [
                "Le guide pratique de l'ADEME vous aidera à mieux choisir vos ampoules.",
"Toutes les jeter ne servira à rien (et peut vous coûter une petite fortune !). Pensez à les remplacer au fur et à mesure que vos anciennes ampoules ne fonctionnent plus.",
"Munissez-vous à l'avance d'une ou deux ampoules basse consommation, vous serez d'ores et déjà paré(e) en cas de panne !"
            ], elo: Elo(energy: 200, waste: 0, food: 0),
            results: "0,0017kg de CO2 par jour",
            bgColor: .purple

    )

    static func getMissions(_ n: Int) -> [Mission] {

        return [m1, m2, m3, m4] + [
            Mission(
                    id: UUID("aea13eae-8831-11e9-bc42-526af7764f64"),
                    duration: 0,
                    description: "Supprimer ses anciens mails",
                    image: "supprimer-email.jpg",
                    mainSubject: "energy",
                    explanations: "La pollution numérique émet autant de gaz à effet de serre que l'aviation civile ! Si 1 000 personnes effacent 160 e-mails, on économise l'équivalent en émission de CO2 d'un aller-retour Paris/New York.",
                    tips: ["Supprimez vos anciens mails avec photos ou vidéos une fois les fichiers récupérés.","Désabonnez-vous des newsletters qui ne vous intéressent plus.","Utilisez CleanFox pour faciliter cette démarche ! (https://www.cleanfox.io/fr-FR/)"
                    ],
                    elo: Elo(energy: 100, waste: 0, food: 0),
                    results: "0,004kg de CO2 par jour",
                    bgColor: .green
            ),Mission(
                    id: UUID("aea1435e-8831-11e9-bc42-526af7764f64"),
                    duration: 0,
                    description: "Changer pour un moteur de recherche responsable",
                    image: "moteur-recherche-responsable.jpg",
                    mainSubject: "energy",
                    explanations: "L'impact environnemental du numérique est gigantesque, et continue à augmenter chaque jour : une recherche Google émet 7 grammes de CO2, soit l'équivalent d'un kilomètre en voiture pour 30 recherches ! Imaginez alors le résultat pour une moyenne de 100 milliards de recherches par mois ! Un des meilleurs moyens d'inverser la tendance est d'utiliser des moteurs de recherche engagés et responsables, comme Ecosia ou Lilo !",
                    tips: ["Utilisez un moteur de recherche qui agit pour la planète et notre bien-être ! Ecosia, qui vous permet de planter des arbres pour chaque recherche, ou Lilo, qui vous permet de cumuler des crédits que vous pouvez répartir entre plusieurs associations, écologiques ou humanitaires."],
                    elo: Elo(energy: 140, waste: 0, food: 0),
                    results: "0,007kg de CO2 par jour",
                    bgColor: .green
            ),Mission(
                    id: UUID("aea1448a-8831-11e9-bc42-526af7764f64"),
                    duration: 3,
                    description: "Penser à ses sacs réutilisables pour les courses",
                    image: "sac-reutilisable.jpg",
                    mainSubject: "waste",
                    explanations: "Avant l'interdiction des sacs plastiques à usage unique de 2016, près de 17 milliards de sacs en polyéthylène, plastiques fabriqués à partir du pétrole, étaient distribués en France chaque année. Malgré cette interdiction, on retrouve toujours des sacs en papier ou plastique en vente aux caisses des supermarchés ou chez les commerçants. Le plus simple pour lutter ? Toujours avoir un sac réutilisable sur soi : ça ne prend pas de place, coûte moins cher et surtout, aide à la préservation de la planète et des océans.",
                    tips: [
                        "Ayez toujours un sac en tissu plié dans votre sac !",
                        "Vous avez peur d'oublier ? Programmez un rappel pour le prendre lors de votre jour de courses habituel !"
                    ],
                    elo: Elo(energy: 0, waste: 160, food: 0),
                    results: "0,0022kg de CO2 par jour",
                    bgColor: .pink
            ),Mission(
                    id: UUID(),
                    duration: 0,
                    description: "Choisir des œufs de poules élevées en plein air",
                    image: "oeufs-plein-air.jpg",
                    mainSubject: "food",
                    explanations: """
                                  Il est facile de se faire avoir par une photo de poule gambadant dans l'herbe sur une boîte d'œufs. Pourtant, aujourd'hui, 70% des œufs consommés sont issus d'élevage de poules en batterie.
                                          Il existe un moyen très facile de déterminer la provenance des œufs, grâce au code indiqué sur la coquille !
                                          0 : œufs bio de poules élevées en plein air
                                          1 : œufs de poules élevées en plein air
                                          2 : œufs de poules élevées au sol ne voyant jamais le jour
                                          3 : œufs de poules élevées en cage ne voyant jamais le jour
                                  """,
                    tips: [
                        "Regardez quel chiffre se trouve sur vos œufs : privilégiez les œufs marqués d'un 0 ou 1, à la rigueur",
        "Si vous avez un doute, optez pour des œufs bio : ce sont forcément des 0 !"
        ],
        elo: Elo(energy: 0, waste: 0, food: 100),
        results: "0,13 kg de CO2 par jour",
        bgColor: .green
        )
        ]
    }
}
