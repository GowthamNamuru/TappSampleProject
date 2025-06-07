//
//  DateHelpers.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import Foundation

extension Date {
    func isPreviousDay() -> Bool {
        let calendar = Calendar.current
        guard let yesterday = calendar.date(byAdding: .day, value: -1, to: Date()) else { return false }
        return calendar.isDate(self, inSameDayAs: yesterday)
    }

    func isCurrentDay() -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: Date())
    }

    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MMM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
}
