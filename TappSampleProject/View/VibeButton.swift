//
//  VibeButton.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import SwiftUI

struct VibeButton: View {
    let emoji: String
    let title: String
    let action: () -> Void

    @State private var bounce = false

    var body: some View {
        Button(action: {
            // Start bounce
            withAnimation(.interpolatingSpring(stiffness: 120, damping: 6)) {
                bounce = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                bounce = false
            }

            // Perform action
            action()
        }) {
            HStack {
                Text(emoji)
                    .font(.title)
                    .scaleEffect(bounce ? 1.5 : 1.0)
                Text(title)
                    .font(.title3)
                    .foregroundColor(.primary)
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(12)
        }
    }
}
#Preview {
    VibeButton(emoji: "💪", title: "Power", action: {})
}
