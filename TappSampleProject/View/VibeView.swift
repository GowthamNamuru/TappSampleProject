//
//  VibeView.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import SwiftUI

struct VibeView: View {

    @StateObject private var viewModel = VibeViewModel(vibeStore: VibeDataProvider(VibeRequirements.storeLocation()))

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.title)
                .font(.title)

            ForEach(viewModel.availableVibes, id: \.self) { vibe in

                VibeButton(emoji: vibe.emoji, title: vibe.text) {
                    withAnimation(.spring()) {
                        viewModel.update(selected: vibe)
                    }
                }
                .scaleEffect(viewModel.selectedVibe == vibe ? 1.3 : 1.0)
            }

            if let text = viewModel.selectedVibeText {
                Text(text)
                    .font(.headline)
                    .padding(.top)
            }
        }
        .padding()
        .onAppear {
            viewModel.load()
        }
        .displayConfetti(isActive: $viewModel.showSuprise)
    }
}

#Preview {
    VibeView()
}
