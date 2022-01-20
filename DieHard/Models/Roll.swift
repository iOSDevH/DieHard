//
//  Roll.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import Foundation

struct Roll: Codable {
    var id = UUID()
    let dice: [Dice]
    let date: Date
    var total: Int {
        var rollTotal = 0
        
        for die in dice {
            rollTotal += die.currentRoll
        }
        
        return rollTotal
    }
    
    
    static let example = Roll(dice: Dice.example, date: Date())
}
