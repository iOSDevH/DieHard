//
//  SettingsScreen.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject var appState: AppState
    
    let rows = [
             GridItem(.flexible()),
             GridItem(.flexible())
         ]
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    HStack {
                        Text("Number of dice:")
                            .font(.title)
                            .foregroundColor(appState.colours[appState.selectedColourIndex])
                        
                        Image(systemName: "die.face.\(appState.dice.count)")
                            .font(.largeTitle)
                            .foregroundColor(appState.colours[appState.selectedColourIndex])
                        
                        Spacer()
                        
                        Button {
                            appState.decreaseDice()
                        } label:{
                            Image(systemName: "minus.circle")
                                .font(.title)
                                .foregroundColor(appState.colours[appState.selectedColourIndex])
                        }
                        .disabled(appState.dice.count < 2)
                        
                        Button {
                            appState.increaseDice()
                        } label:{
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundColor(appState.colours[appState.selectedColourIndex])
                        }
                        .disabled(appState.dice.count > 5)
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text("Pick a colour:")
                            .font(.title)
                            .foregroundColor(appState.colours[appState.selectedColourIndex])
                        
                        LazyHGrid(rows: rows, spacing: 20) {
                            ForEach(appState.colours, id: \.self) { colour in
                                Button {
                                    appState.selecteColour(colour)
                                } label: {
                                    if appState.selectedColourIndex == appState.colours.firstIndex(of: colour) {
                                        Rectangle()
                                            .fill(colour)
                                            .frame(width: 44, height: 44)
                                            .border(Color.gray, width: 5)
                                    } else {
                                        Rectangle()
                                            .fill(colour)
                                            .frame(width: 44, height: 44)
                                    }
                                    
                                        
                                }
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("Settings")
                .onAppear { navBarColour(colourIndex: appState.selectedColourIndex) }
                .onChange(of: appState.selectedColourIndex) { _ in
                    navBarColour(colourIndex: appState.selectedColourIndex)
                }
            }
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
