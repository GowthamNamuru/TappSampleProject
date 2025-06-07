//
//  VibeProvider.swift
//  VibeWidgetExtension
//
//  Created by Gowtham Namuru on 07/06/25.
//

import WidgetKit
import SwiftUI

struct VibeProvider: TimelineProvider {
    private var viewModel: VibeStoreProtocol = VibeDataProvider(VibeRequirements.storeLocation())

    func placeholder(in context: Context) -> VibeEntryViewModel {
        VibeEntryViewModel(date: Date(), vibe: nil, count: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (VibeEntryViewModel) -> ()) {
        completion(loadEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<VibeEntryViewModel>) -> ()) {
        let entry = loadEntry()
        completion(Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 15))))
    }

    func loadEntry() -> VibeEntryViewModel {
        if let decoded = viewModel.vibes() {
            let last = decoded.last?.vibe
            let weekCount = decoded.filter {
                Calendar.current.isDate($0.timestamp, equalTo: Date(), toGranularity: .weekOfYear)
            }.count
            return VibeEntryViewModel(date: Date(), vibe: last, count: weekCount)
        }
        return VibeEntryViewModel(date: Date(), vibe: nil, count: 0)
    }
}
