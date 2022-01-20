//
//  Dice.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import Foundation

struct Dice: Codable {
    var id = UUID()
    var numberOfSides = 6
    var currentRoll: Int
    
    static let example: [Dice] = [Dice(numberOfSides: 6, currentRoll: 1),
                                  Dice(numberOfSides: 6, currentRoll: 2),
                                  Dice(numberOfSides: 6, currentRoll: 3),
                                  Dice(numberOfSides: 6, currentRoll: 4),
                                  Dice(numberOfSides: 6, currentRoll: 5),
                                  Dice(numberOfSides: 6, currentRoll: 6)]
}
