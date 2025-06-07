//
//  SplashScreenView.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive: Bool
    @State private var pulse = false

    var body: some View {
        ZStack {
            Color.white
            VStack {
                Image(systemName: "sparkles")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
                    .foregroundStyle(.purple)

                Text("Vibe App")
                    .font(.largeTitle)
                    .bold()
                    .overlay {
                        LinearGradient(colors: [.pink, .orange, .purple], startPoint: .leading, endPoint: .trailing)
                    }
                    .mask {
                        Text("Vibe App")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .scaleEffect(pulse ? 1 : 0.5)
                    .animation(.easeOut(duration: 1.5).repeatForever(autoreverses: true), value: pulse)
                    .onAppear {
                        pulse = true
                    }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            // Auto-dismiss after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = false
                }
            }
        }
    }
}

#Preview {
    SplashScreenView(isActive: .constant(true))
}
