//
//  DieHardApp.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-19.
//

import SwiftUI

@main
struct DieHardApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
