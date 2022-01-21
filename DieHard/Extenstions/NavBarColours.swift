//
//  NavBarColours.swift
//  DieHard
//
//  Created by Heath Fashina on 2022-01-20.
//

import SwiftUI

extension View {
    func navBarColour(colourIndex: Int) {
        let colours: [UIColor] = [.systemRed, .systemYellow, .systemGreen, .systemPurple, .systemOrange, .systemBlue, .white, .systemBrown]
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: colours[colourIndex]]
        navBarAppearance.titleTextAttributes = [.foregroundColor: colours[colourIndex]]
        navBarAppearance.configureWithTransparentBackground()
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
}
