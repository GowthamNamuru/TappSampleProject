//
//  VibeProvider.swift
//  VibeWidgetExtension
//
//  Created by Gowtham Namuru on 07/06/25.
//

import WidgetKit
import SwiftUI

struct VibeProvider: TimelineProvider {
    private var viewModel: VibeDataProvider = VibeDataProvider("group.com.tapp.tappSample")

    func placeholder(in context: Context) -> VibeEntry {
        VibeEntry(date: Date(), vibe: nil, count: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (VibeEntry) -> ()) {
        completion(loadEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<VibeEntry>) -> ()) {
        let entry = loadEntry()
        completion(Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 15))))
    }

    func loadEntry() -> VibeEntry {
        if let decoded = viewModel.vibes() {
            let last = decoded.last?.vibe
            let weekCount = decoded.filter {
                Calendar.current.isDate($0.timestamp, equalTo: Date(), toGranularity: .weekOfYear)
            }.count
            return VibeEntry(date: Date(), vibe: last, count: weekCount)
        }
        return VibeEntry(date: Date(), vibe: nil, count: 0)
    }
}

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
