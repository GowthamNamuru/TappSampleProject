//
//  VibeWidget.swift
//  VibeWidgetExtension
//
//  Created by Gowtham Namuru on 07/06/25.
//

import WidgetKit
import SwiftUI

@main
struct VibeWidget: Widget {
    let kind: String = "VibeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: VibeProvider()) {
            VibeWidgetView(entry: $0)
        }
        .configurationDisplayName("Vibe of the day")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}


#Preview(as: .systemMedium) {
    VibeWidget()
} timeline: {
    VibeEntry(date: .now, vibe: nil, count: 0)
    VibeEntry(date: .now + 1, vibe: .focus, count: 1)
}

#Preview(as: .systemLarge) {
    VibeWidget()
} timeline: {
    VibeEntry(date: .now, vibe: nil, count: 0)
    VibeEntry(date: .now + 1, vibe: .focus, count: 1)
}
