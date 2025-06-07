//
//  VibeViewModel.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import Combine
import WidgetKit

protocol VibeStoreProtocol {
    var count: Int { get }

    func store(_ vibe: Vibe, timeStamp: () -> Date)
    func vibes() -> [SelectedVibes]?
}


final class VibeViewModel: ObservableObject {
    @Published private(set) var selectedVibe: Vibe?
    @Published private(set) var vibeCount: Int = 0
    @Published private(set) var timeStamp: Date?
    @Published var showSuprise: Bool = false

    var selectedVibeText: String? {
        guard let selectedVibe else {
            return nil
        }
        var text = "Your vibe for "
        if let date = timeStamp {
            if date.isPreviousDay() {
                text += "yesterday is: "
            } else if date.isCurrentDay() {
                text += "today is: "
            } else {
                text += "\(date.formattedDate()) is: "
            }
        }
        text += "\(selectedVibe.rawValue)"
        return text
    }

    let availableVibes: [Vibe] = Vibe.all

    private var vibeStore: VibeStoreProtocol

    init(vibeStore: VibeStoreProtocol) {
        self.vibeStore = vibeStore
    }

    func update(selected vibe: Vibe, date: Date = Date()) {
        selectedVibe = vibe
        timeStamp = date
        vibeStore.store(vibe, timeStamp: {date})
        vibeCount = vibeStore.count
        showSuprise = shouldSuprise()
    }

    func load() {
        let previousVibe = vibeStore.vibes()?.sorted { $0.timestamp > $1.timestamp }.first
        (selectedVibe, timeStamp) = (previousVibe?.vibe, previousVibe?.timestamp)
    }

    private func shouldSuprise() -> Bool {
        if let vibesCount = vibeStore.vibes()?.count, vibesCount.isMultiple(of: Constants.threasholdForSuprise) {
            return true
        }
        return false
    }

    private enum Constants {
        static let threasholdForSuprise: Int = 7
    }
}
