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
                        .foregroundColor(appState.colours[appState.selectedColourIndex])
                        .padding(.top)
                    
                    Text("\(appState.rollTotal)")
                        .font(.system(size: geo.size.width / 4))
                        .foregroundColor(appState.colours[appState.selectedColourIndex])
                    
                    
                    HStack {
                        ForEach(oddDice, id: \.id) { die in
                           // if index % 2 == 0 {
                                Image(systemName: "die.face.\(die.currentRoll)")
                                    .font(.system(size: geo.size.width / 4))
                                    .foregroundColor(appState.colours[appState.selectedColourIndex])
                           // }
                        }
                    }
                    .padding()
                    
                    HStack {
                        ForEach(evenDice, id: \.id) { die in
                            //if index % 2 == 1 {
                            Image(systemName: "die.face.\(die.currentRoll)")
                                .font(.system(size: geo.size.width / 4))
                                .foregroundColor(appState.colours[appState.selectedColourIndex])
                            //}
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
                        .foregroundColor(appState.colours[appState.selectedColourIndex] == .white ? .black : .white)
                        .padding(10)
                        .frame(width: geo.size.width / 1.1)
                        .background(appState.colours[appState.selectedColourIndex])
                        .clipShape(Capsule())
                        
                    }
                    .padding(.bottom)
                }
            }
            .preferredColorScheme(.dark)
            .onAppear(perform: navBarColour)
            .onChange(of: appState.selectedColourIndex) { _ in
                navBarColour()
            }
            
        }
    }
    
    func navBarColour() {
        let colours: [UIColor] = [.systemRed, .systemYellow, .systemGreen, .systemPurple, .systemOrange, .systemBlue, .white, .systemBrown]
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: colours[appState.selectedColourIndex]]
        navBarAppearance.titleTextAttributes = [.foregroundColor: colours[appState.selectedColourIndex]]
        navBarAppearance.configureWithTransparentBackground()
        
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
