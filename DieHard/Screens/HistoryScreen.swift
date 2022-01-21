//
//  HistoryScreen.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import SwiftUI

struct HistoryScreen: View {
    @EnvironmentObject var appState: AppState
    
    @State private var clearHistoryAlert = false
    
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
                    .onDelete(perform: remove)
                }
            }
            .navigationTitle("History")
            .onAppear { navBarColour(colourIndex: appState.selectedColourIndex) }
            .onChange(of: appState.selectedColourIndex) { _ in
                navBarColour(colourIndex: appState.selectedColourIndex)
            }
            .toolbar {
                Button("Clear") {
                    clearHistoryAlert = true
                }
            }
            .alert("Are you sure?", isPresented: $clearHistoryAlert) {
                Button(role: .destructive, action: appState.clearHistory) {
                    Text("OK")
                }
            }
        }
    }
    
    func remove(at offsets: IndexSet) {
        for i in offsets {
            appState.removeFromHistory(at: i)
        }
    }
}

struct HistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen()
    }
}
