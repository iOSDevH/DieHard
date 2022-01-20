//
//  AppState.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import Foundation

class AppState: ObservableObject {
    @Published var history: [Roll]
    @Published var dice: [Dice]
    
    var rollTotal: Int {
        var rollTotal = 0
        
        for die in dice {
            rollTotal += die.currentRoll
        }
        
        return rollTotal
    }
    
    init() {
        history = []
        dice = Dice.example
    }
    
    func roll() {
        for i in 0..<dice.count {
            let dice = Dice(currentRoll: Int.random(in: 1..<dice[i].numberOfSides))
            self.dice[i] = dice
        }
        addToHistory(dice)
    }
    
    func addToHistory(_ dice: [Dice]) {
        let roll = Roll(dice: self.dice, date: Date())
        history.append(roll)
    }
    
}
