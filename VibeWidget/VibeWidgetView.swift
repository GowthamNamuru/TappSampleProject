//
//  VibeWidgetView.swift
//  VibeWidgetExtension
//
//  Created by Gowtham Namuru on 07/06/25.
//

import SwiftUI

struct VibeWidgetView: View {
    let entry: VibeEntry

    var body: some View {
        VStack(spacing: 8) {
            if let vibe = entry.vibe {
                Text("Today’s Vibe")
                    .font(.headline)
                Text(vibe.rawValue)
                    .font(.largeTitle)
                    .scaleEffect(entry.count % 7 == 0 ? 1.2 : 1.0)
                    .animation(.spring(), value: entry.count)
            } else {
                Text("No vibe yet — pick one!")
            }

            Text("You've picked \(entry.count) vibes this week.")
                .font(.footnote)

            if entry.count % 7 == 0 && entry.count != 0 {
                Text("🎉")
                    .font(.largeTitle)
            }
        }
        .padding()
        .widgetURL(URL(string: "vibeapp://open"))
    }
}

#Preview {
    VibeWidgetView(entry: VibeEntry(date: Date(), vibe: .focus, count: 1))
}
