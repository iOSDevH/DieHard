//
//  RollScreen.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import SwiftUI

struct RollScreen: View {
    @EnvironmentObject var appState: AppState
    
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
        GeometryReader { geo in
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("You rolled:")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .padding(.top)
                    
                    Text("\(appState.rollTotal)")
                        .font(.system(size: geo.size.width / 4))
                        .foregroundColor(.red)
                    
                    
                    HStack {
                        ForEach(0..<oddDice.count) { index in
                            Image(systemName: "die.face.\(oddDice[index].currentRoll)")
                                .font(.system(size: geo.size.width / 4))
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    
                    HStack {
                        ForEach(0..<evenDice.count) { index in
                            Image(systemName: "die.face.\(evenDice[index].currentRoll)")
                                .font(.system(size: geo.size.width / 4))
                                .foregroundColor(.red)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            appState.roll()
                        } label: {
                            Label("Roll", systemImage: "die.face.6")
                                .font(.largeTitle)
                        }
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(width: geo.size.width / 1.1)
                        .background(.red)
                        .clipShape(Capsule())
                        
                    }
                    .padding(.bottom)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .red
        
    }
}

struct RollScreen_Previews: PreviewProvider {
    static var previews: some View {
        RollScreen()
    }
}
