//
//  VibeWidgetView.swift
//  VibeWidgetExtension
//
//  Created by Gowtham Namuru on 07/06/25.
//

import SwiftUI

struct VibeWidgetView: View {
    let entry: VibeEntryViewModel

    var body: some View {
        VStack(spacing: 8) {
            Text(entry.text)
                .font(.headline)
            if let subTitle = entry.subTitle {
                Text(subTitle)
                    .font(.largeTitle)
            }
            VStack {
                Text(entry.pickedVibeText)
                    .font(.footnote)
                if let supriseText = entry.supriseText {
                    Text(supriseText)
                        .font(.footnote)
                        .overlay {
                            LinearGradient(colors: [.pink, .orange, .purple], startPoint: .leading, endPoint: .trailing)
                        }
                        .mask {
                            Text(supriseText)
                                .font(.footnote)
                        }
                }
            }
        }
        .padding()
        .widgetURL(URL(string: VibeRequirements.deepLinkScheme()))
    }
}

#Preview {
    VibeWidgetView(entry: VibeEntryViewModel(date: Date(), vibe: .focus, count: 1))
}
