//
//  HistoryScreen.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import SwiftUI

struct HistoryScreen: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geo in
                List {
                    ForEach(appState.history, id: \.id) { roll in
                        VStack(alignment: .leading) {
                            HStack {
                                ForEach(roll.dice, id: \.id) { die in
                                    Image(systemName: "die.face.\(die.currentRoll)")
                                        .font(.system(size: geo.size.width / 14))
                                        .foregroundColor(appState.colours[appState.selectedColourIndex])
                                }
                                
                                Text("= \(roll.total)")
                                    .font(.system(size: geo.size.width / 14))
                                    .foregroundColor(appState.colours[appState.selectedColourIndex])
                            }
                            .padding(.vertical, 2)
                            
                            Text("Rolled: \(roll.date.formatted())")
                                .font(.caption)
                                .foregroundColor(appState.colours[appState.selectedColourIndex])
                                .offset(x: 10)
                        }
                    }
                }
            }
            .navigationTitle("History")
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

struct HistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen()
    }
}
