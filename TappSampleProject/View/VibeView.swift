//
//  VibeView.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import SwiftUI

struct VibeView: View {

    @StateObject private var viewModel = VibeViewModel(vibeStore: VibeDataProvider("group.com.tapp.vibeapp"))

    var body: some View {
        VStack(spacing: 20) {
            Text("Pick your vibe")
                .font(.title)

            ForEach(viewModel.availableVibes, id: \.self) { vibe in
                Button {
                    withAnimation(.spring()) {
                        viewModel.update(selected: vibe)
                    }
                } label: {
                    Text(vibe.rawValue)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .scaleEffect(viewModel.selectedVibe == vibe ? 1.3 : 1.0)
                }
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
    }
}

#Preview {
    VibeView()
}
