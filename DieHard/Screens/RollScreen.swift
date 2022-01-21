//
//  RollScreen.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import SwiftUI

struct RollScreen: View {
    @EnvironmentObject var appState: AppState
    
    @State private var rollingFeedback = UINotificationFeedbackGenerator()
    @State private var isRolling = false
    @State private var rolls = 6
    @State private var diceRotation = 0.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var oddDice: [Dice] {
        var oddDice = [Dice]()
        
        for i in 0..<appState.dice.count {
            if i % 2 == 0 {
                oddDice.append(appState.dice[i])
            }
        }
        
        return oddDice
    }
    
    var evenDice: [Dice] {
        var evenDice = [Dice]()
        
        for i in 0..<appState.dice.count {
            if i % 2 == 1 {
                evenDice.append(appState.dice[i])
            }
        }
        
        return evenDice
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Group {
                            Text("You rolled:")
                                .font(.largeTitle)
                                .foregroundColor(appState.colours[appState.selectedColourIndex])
                                .padding(.top)
                            
                            Text("\(appState.rollTotal)")
                                .font(.system(size: geo.size.width / 4))
                                .foregroundColor(appState.colours[appState.selectedColourIndex])
                        }
                        .opacity(isRolling ? 0.0 : 1.0)

                        
                        HStack {
                            ForEach(oddDice, id: \.id) { die in
                                    Image(systemName: "die.face.\(die.currentRoll)")
                                        .font(.system(size: geo.size.width / 4))
                                        .foregroundColor(appState.colours[appState.selectedColourIndex])
                                        .rotationEffect(.degrees(diceRotation))
                            }
                        }
                        .padding(.bottom)
                        
                        HStack {
                            ForEach(evenDice, id: \.id) { die in
                                Image(systemName: "die.face.\(die.currentRoll)")
                                    .font(.system(size: geo.size.width / 4))
                                    .foregroundColor(appState.colours[appState.selectedColourIndex])
                                    .rotationEffect(.degrees(-diceRotation))
                            }
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button {
                                rollingFeedback.prepare()
                                isRolling = true
//                                appState.roll()
//                                rollingFeedback.notificationOccurred(.warning)
                            } label: {
                                Label("Roll", systemImage: "die.face.6")
                                    .font(.largeTitle)
                            }
                            .foregroundColor(appState.colours[appState.selectedColourIndex] == .white ? .black : .white)
                            .padding(10)
                            .frame(width: geo.size.width / 1.1)
                            .background(appState.colours[appState.selectedColourIndex])
                            .clipShape(Capsule())
                            
                        }
                        .padding(.bottom)
                        .onReceive(timer) { time in
                            guard isRolling else { return }
                            
                            appState.roll()
                            rollingFeedback.notificationOccurred(.warning)
                            diceRotation += 30.0
                            rolls -= 1
                            if rolls == 0 {
                                diceRotation = 0.0
                                appState.finishRoll()
                                rolls = 6
                                isRolling = false
                            }
                            
                        }
                        
                        Spacer()
                    }
                }
                
                
            }
            .navigationTitle("Die Hard!")
            .preferredColorScheme(.dark)
            .onAppear { navBarColour(colourIndex: appState.selectedColourIndex) }
            .onChange(of: appState.selectedColourIndex) { _ in
                navBarColour(colourIndex: appState.selectedColourIndex)
            }
        }
    }
}

struct RollScreen_Previews: PreviewProvider {
    static var previews: some View {
        RollScreen()
    }
}
