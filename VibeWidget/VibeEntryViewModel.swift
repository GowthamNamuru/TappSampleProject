//
//  VibeEntryViewModel.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 08/06/25.
//

import WidgetKit
import SwiftUI

struct VibeEntryViewModel: TimelineEntry {
    let date: Date
    let vibe: Vibe?
    let count: Int

    var text: String {
        vibe != nil ? "Today’s Vibe" : "No vibe yet — pick one!"
    }

    var subTitle: String? {
        guard let vibe else {
            return nil
        }
        return "\(vibe.emoji)  \(vibe.text)"
    }

    var pickedVibeText: String {
        "You've picked \(count) vibes this week."
    }

    var supriseText: String? {
        if shouldSuprise {
            return "You have a SUPRISE. Tap to see"
        }
        return nil
    }

    var shouldSuprise: Bool {
        count != 0 && count.isMultiple(of: 7)
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
