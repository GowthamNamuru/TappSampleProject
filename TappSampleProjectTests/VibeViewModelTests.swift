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
        let viewModel = VibeViewModel()
        
        let selectedVibe = viewModel.selectedVibe

        XCTAssertNil(selectedVibe, "Selected vibe should be nil")
    }

    func test_selectedVibe_shouldNotBeNilWhenAssigned() {
        let viewModel = VibeViewModel()

        viewModel.update(selected: .chill)

        XCTAssertEqual(viewModel.selectedVibe, .chill, "Selected vibe should not be nil")
    }

    func test_selectedView_whenUpdatedShouldIncreaseCount() {
        let viewModel = VibeViewModel()

        viewModel.update(selected: .focus)

        XCTAssertEqual(viewModel.vibeCount, 1, "Vibe count should increase")
    }
}
