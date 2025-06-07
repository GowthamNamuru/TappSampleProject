//
//  VibeViewModel.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import Combine
import WidgetKit

protocol VibeStoreProtocol {
    func updateVibe(_ vibe: Vibe)
    func getVibe() -> Vibe?
    func vibeCount() -> Int
}


final class VibeViewModel: ObservableObject {
    @Published private(set) var selectedVibe: Vibe?
    @Published private(set) var vibeCount: Int = 0

    private var vibeStore: VibeStoreProtocol

    init(vibeStore: VibeStoreProtocol) {
        self.vibeStore = vibeStore
    }

    func update(selected vibe: Vibe) {
        selectedVibe = vibe
        vibeStore.updateVibe(vibe)
        vibeCount += 1
    }
}
