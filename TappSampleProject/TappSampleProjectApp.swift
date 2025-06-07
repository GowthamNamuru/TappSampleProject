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
    @State private var showAlert: Bool = false

    var body: some Scene {
        WindowGroup {
            if isSplashActive {
                SplashScreenView(isActive: $isSplashActive)
            } else {
                VibeView()
                    .onOpenURL { url in
                        if url.absoluteString == VibeRequirements.deepLinkScheme() {
                            showAlert = true
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        // We can add our implementations. As of now we don't many screens to navigate so showing the alert to differenciate the launch type.
                        Alert(title: Text("Launched from Widget!"), message: Text("Pick Vibe for today!"), dismissButton: .default(Text("Okay")))
                    }
            }
        }
    }
}
