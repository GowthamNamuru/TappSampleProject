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

        sut.update(selected: .focus)

        XCTAssertEqual(sut.vibeCount, 1, "Vibe count should increase")
    }

    func test_selectedVibe_onUpdateShouldStore() {
        let (sut, store) = makeSUT()

        sut.update(selected: .joy)

        XCTAssertEqual(store.getVibe(), .joy)
        XCTAssertEqual(store.vibeCount(), 1)
    }

    // MARK: - Helpers
    private func makeSUT() -> (sut: VibeViewModel, store: VibeStoreProtocol) {
        let vibeStoreMock = VibeStoreMock()
        return (VibeViewModel(vibeStore: vibeStoreMock), vibeStoreMock)
    }

    private class VibeStoreMock: VibeStoreProtocol {
        private(set) var count = 0
        private(set) var selectedVibe: Vibe?

        func updateVibe(_ vibe: TappSampleProject.Vibe) {
            selectedVibe = vibe
            count += 1
        }
        
        func getVibe() -> TappSampleProject.Vibe? {
            selectedVibe
        }
        
        func vibeCount() -> Int {
            count
        }
    }
}
