//
//  AppState.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var history: [Roll]
    @Published var dice: [Dice]
    @AppStorage("selectedColourIndex") var selectedColourIndex: Int = 0
    
    let colours: [Color] = [.red, .yellow, .green, .purple, .orange, .blue, .white, .brown]
    
    let diceSavePath = FileManager.documentsDirectory.appendingPathComponent("SavedDice")
    let historySavePath = FileManager.documentsDirectory.appendingPathComponent("SavedHistory")
    
    var rollTotal: Int {
        var rollTotal = 0
        
        for die in dice {
            rollTotal += die.currentRoll
        }
        
        return rollTotal
    }
    
    init() {
        history = []
        dice = []
        loadData()
    }
    
    func loadData() {
        do {
            let diceData = try Data(contentsOf: diceSavePath)
            let historyData = try Data(contentsOf: historySavePath)
            dice = try JSONDecoder().decode([Dice].self, from: diceData)
            history = try JSONDecoder().decode([Roll].self, from: historyData)
        } catch {
            dice = Dice.example
            history = []
        }
    }
    
    private func saveData() {
        do {
            let diceData = try JSONEncoder().encode(dice)
            let historyData = try JSONEncoder().encode(history)
            try diceData.write(to: diceSavePath, options: [.atomicWrite, .completeFileProtection])
            try historyData.write(to: historySavePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func roll() {
        for i in 0..<dice.count {
            let dice = Dice(currentRoll: Int.random(in: 1..<dice[i].numberOfSides))
            self.dice[i] = dice
        }
        addToHistory(dice)
        saveData()
    }
    
    func addToHistory(_ dice: [Dice]) {
        let roll = Roll(dice: self.dice, date: Date())
        history.append(roll)
    }
    
    func increaseDice() {
        if dice.count < 6 {
            dice.append(Dice(currentRoll: 6))
        }
        saveData()
    }
    
    func decreaseDice() {
        if dice.count > 1 {
            dice.removeLast()
        }
        saveData()
    }
    
    func selecteColour(_ colour: Color) {
        selectedColourIndex = colours.firstIndex(of: colour) ?? 0
    }
    
}
