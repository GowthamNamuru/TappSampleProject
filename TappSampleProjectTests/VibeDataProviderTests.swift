//
//  VibeDataProviderTests.swift
//  TappSampleProjectTests
//
//  Created by Gowtham Namuru on 07/06/25.
//

import XCTest
@testable import TappSampleProject

final class VibeDataProviderTests: XCTestCase {
    func test_initilise_shouldGetFromSuite() {
        let sut = makeSUT()

        XCTAssertNil(sut.vibes())
    }

    func test_storeVibe_shouldGetVibe() {
        let sut = makeSUT()
        let date = Date()

        let expectedVibe: [SelectedVibes] = [.init(vibe: .focus, timeStamp: date)]

        sut.storeVibe(.focus, timeStamp: {date})

        XCTAssertEqual(sut.vibes(), expectedVibe)
    }

    func test_storeMultipleVibe_shouldGetMultipleVibe() {
        let sut = makeSUT()
        let date1 = Date()
        let date2 = Date()

        let expectedVibe: [SelectedVibes] = [.init(vibe: .focus, timeStamp: date1), .init(vibe: .focus, timeStamp: date2)]

        sut.storeVibe(.focus, timeStamp: {date1})
        sut.storeVibe(.focus, timeStamp: {date2})

        XCTAssertEqual(sut.vibes(), expectedVibe)
    }

    // MARK: Helpers

    private func makeSUT(suiteName: String = "com.test.tapp") -> VibeDataProvider {
        let store = VibeDataProvider(suiteName)
        // Remove artifacts after every test case.
        clearUserDefaults(for: suiteName)
        return store
    }
}

extension XCTestCase {
    func clearUserDefaults(for suiteName: String) {
        guard let defaults = UserDefaults(suiteName: suiteName) else {
            return
        }

        defaults.dictionaryRepresentation().keys.forEach {
            defaults.removeObject(forKey: $0)
        }
    }
}

extension SelectedVibes: @retroactive Equatable {
    public static func == (lhs: SelectedVibes, rhs: SelectedVibes) -> Bool {
        return lhs.vibe == rhs.vibe && lhs.timestamp == rhs.timestamp
    }
}
