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

        XCTAssertNil(selectedVibe)
    }

    func test_selectedVibe_shouldNotBeNilWhenAssigned() {
        let viewModel = VibeViewModel()

        viewModel.selectedVibe = .chill

        XCTAssertEqual(viewModel.selectedVibe, .chill)
    }
}
