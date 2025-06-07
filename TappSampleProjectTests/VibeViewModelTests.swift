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
        let sut = makeSUT()

        let selectedVibe = sut.selectedVibe

        XCTAssertNil(selectedVibe, "Selected vibe should be nil")
    }

    func test_selectedVibe_shouldNotBeNilWhenAssigned() {
        let sut = makeSUT()

        sut.update(selected: .chill)

        XCTAssertEqual(sut.selectedVibe, .chill, "Selected vibe should not be nil")
    }

    func test_selectedView_whenUpdatedShouldIncreaseCount() {
        let sut = makeSUT()

        sut.update(selected: .focus)

        XCTAssertEqual(sut.vibeCount, 1, "Vibe count should increase")
    }

    // MARK: - Helpers
    private func makeSUT() -> VibeViewModel {
        VibeViewModel()
    }
}
