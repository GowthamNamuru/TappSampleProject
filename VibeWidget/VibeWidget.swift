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
                .containerBackground($0.backgroundColor.tertiary, for: .widget)
        }
        .configurationDisplayName("Vibe of the day")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}


#Preview(as: .systemMedium) {
    VibeWidget()
} timeline: {
    VibeEntryViewModel(date: .now, vibe: nil, count: 0)
    VibeEntryViewModel(date: .now + 1, vibe: .focus, count: 1)
}

#Preview(as: .systemLarge) {
    VibeWidget()
} timeline: {
    VibeEntryViewModel(date: .now, vibe: nil, count: 0)
    VibeEntryViewModel(date: .now + 1, vibe: .focus, count: 1)
}
