//
//  VibeViewModel.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import Combine
import WidgetKit

class VibeViewModel: ObservableObject {
    @Published var selectedVibe: Vibe?
    @Published var vibeCount: Int = 0

    func update(selected vibe: Vibe) {
        selectedVibe = vibe
    }
}
