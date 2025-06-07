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

    private var vibeStore: VibeStoreProtocol

    init(vibeStore: VibeStoreProtocol) {
        self.vibeStore = vibeStore
    }

    func update(selected vibe: Vibe, date: Date = Date()) {
        selectedVibe = vibe
        vibeStore.store(vibe, timeStamp: {date})
        vibeCount = vibeStore.count
    }
}
