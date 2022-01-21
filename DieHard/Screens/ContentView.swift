//
//  ContentView.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-19.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            RollScreen()
                .tabItem {
                    Image(systemName: "die.face.6")
                    Text("Roll Dice")
                }
            
            HistoryScreen()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("History")
                }
            
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .tint(appState.colours[appState.selectedColourIndex])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
