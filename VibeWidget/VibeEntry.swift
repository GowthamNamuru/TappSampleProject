//
//  VibeEntry.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 08/06/25.
//

import WidgetKit
import SwiftUI

struct VibeEntry: TimelineEntry {
    let date: Date
    let vibe: Vibe?
    let count: Int

    var shouldSuprise: Bool {
        count.isMultiple(of: 7)
    }

    var supriseText: String {
        var text = "You've picked \(count) vibes this week."
        if shouldSuprise {
            text = "You have a SUPRISE. Tap to see"
        }
        return text
    }

    var backgroundColor: Color {
        switch vibe {
        case .joy:
            return .green.opacity(0.6)
        case .chill:
            return .blue.opacity(0.6)
        case .focus:
            return .yellow.opacity(0.6)
        case .power:
            return .red.opacity(0.6)
        default:
            return .gray.opacity(0.6)
        }
    }
}
