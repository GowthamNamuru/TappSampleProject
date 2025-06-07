//
//  TappSampleProjectApp.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import SwiftUI

@main
struct TappSampleProjectApp: App {
    @State private var isSplashActive = true

    var body: some Scene {
        WindowGroup {
            if isSplashActive {
                SplashScreenView(isActive: $isSplashActive)
            } else {
                VibeView()
            }
        }
    }
}
