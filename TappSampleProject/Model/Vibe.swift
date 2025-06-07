//
//  Vibe.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import Foundation

enum Vibe: String, CaseIterable, Codable {
    case focus = "🧠 Focus"
    case power = "💪 Power"
    case chill = "😴 Chill"
    case joy = "😂 Joy"

    static let all: [Vibe] = [.focus, .power, .chill, .joy]
}

struct SelectedVibes: Codable {
    let vibe: Vibe
    let timestamp: Date
    init(vibe: Vibe, timeStamp: Date) {
        self.vibe = vibe
        self.timestamp = timeStamp
    }
}
