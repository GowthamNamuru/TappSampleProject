//
//  Vibe.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import Foundation

enum Vibe: String, CaseIterable {
    case focus = "🧠 Focus"
    case power = "💪 Power"
    case chill = "😴 Chill"
    case joy = "😂 Joy"

    static let all: [Vibe] = [.focus, .power, .chill, .joy]
}
