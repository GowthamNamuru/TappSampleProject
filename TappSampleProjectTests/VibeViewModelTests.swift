//
//  VibeViewModelTests.swift
//  TappSampleProjectTests
//
//  Created by Gowtham Namuru on 07/06/25.
//

import XCTest
@testable import TappSampleProject

final class VibeViewModelTests: XCTestCase {
    func test_selectedVibe_shouldBeNilWhenInitialized() {
        let (sut, _) = makeSUT()

        let selectedVibe = sut.selectedVibe

        XCTAssertNil(selectedVibe, "Selected vibe should be nil")
    }

    func test_selectedVibe_shouldNotBeNilWhenAssigned() {
        let (sut, _) = makeSUT()

        sut.update(selected: .chill)

        XCTAssertEqual(sut.selectedVibe, .chill, "Selected vibe should not be nil")
    }

    func test_selectedVibe_whenUpdatedShouldIncreaseCount() {
        let (sut, _) = makeSUT()
        let date = Date()

        sut.update(selected: .focus, date: date)

        XCTAssertEqual(sut.vibeCount, 1, "Vibe count should increase")
    }

    func test_selectedVibe_onUpdateShouldStore() {
        let (sut, store) = makeSUT()
        let date = Date()

        sut.update(selected: .joy, date: date)
        let expectedVibe = [SelectedVibes(vibe: .joy, timeStamp: date)]

        XCTAssertEqual(store.vibes(), expectedVibe)
        XCTAssertEqual(store.count, 1)
    }

    // MARK: - Helpers
    private func makeSUT() -> (sut: VibeViewModel, store: VibeStoreProtocol) {
        let vibeStoreMock = VibeStoreMock()
        return (VibeViewModel(vibeStore: vibeStoreMock), vibeStoreMock)
    }

    private class VibeStoreMock: VibeStoreProtocol {
        private(set) var vibeCount = 0
        private(set) var selectedVibe: SelectedVibes?

        func store(_ vibe: Vibe, timeStamp: () -> Date) {
            selectedVibe = SelectedVibes(vibe: vibe, timeStamp: timeStamp())
            vibeCount += 1
        }
        
        func vibes() -> [TappSampleProject.SelectedVibes]? {
            selectedVibe != nil ? [selectedVibe!] :  []
        }
        
        var count: Int {
            vibeCount
        }
    }
}
