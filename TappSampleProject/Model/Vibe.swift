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

    var emoji: String {
        switch self {
        case .focus:
            return "🧠"
        case .power:
            return "💪"
        case .chill:
            return "😴"
        case .joy:
            return "😂"
        }
    }

    var text: String {
        switch self {
        case .focus:
            return "Focus"
        case .power:
            return "Power"
        case .chill:
            return "Chill"
        case .joy:
            return "Joy"
        }
    }
}

struct SelectedVibes: Codable {
    let vibe: Vibe
    let timestamp: Date
    init(vibe: Vibe, timeStamp: Date) {
        self.vibe = vibe
        self.timestamp = timeStamp
    }
}
