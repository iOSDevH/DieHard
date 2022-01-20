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
        
        GeometryReader { geo in
            List {
                ForEach(appState.history, id: \.id) { roll in
                    VStack(alignment: .leading) {
                        HStack {
                            ForEach(roll.dice, id: \.id) { die in
                                Image(systemName: "die.face.\(die.currentRoll)")
                                    .font(.system(size: geo.size.width / 14))
                                    .foregroundColor(.red)
                            }
                            
                            Text("= \(roll.total)")
                                .font(.system(size: geo.size.width / 14))
                                .foregroundColor(.red)
                        }
                        .padding(.vertical, 2)
                        
                        Text("Rolled: \(roll.date.formatted())")
                            .font(.caption)
                            .foregroundColor(.red)
                            .offset(x: 10)
                    }
                }
            }
        }
    }
}

struct HistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen()
    }
}
