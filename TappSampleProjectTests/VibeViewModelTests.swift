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

        XCTAssertEqual(store.vibes(), expectedVibe, "Stored vibe should match")
        XCTAssertEqual(store.count, 1, "Store count should increase")
    }

    func test_availableVibes() {
        let (sut, _) = makeSUT()

        XCTAssertEqual(sut.availableVibes, Vibe.all, "All available vibes should be returned")
    }

    func test_selectedVibeText_previouslyStoredVibe() {

        let (sut, store) = makeSUT()
        store.store(.focus, timeStamp: { Date().getDate(byAdding: -1) })

        sut.load()

        XCTAssertEqual(sut.selectedVibeText, "Your vibe for yesterday is: \(Vibe.focus.rawValue)")
    }

    func test_selectedVibeText_shouldBeNil() {
        let (sut, _) = makeSUT()

        XCTAssertNil(sut.selectedVibeText, "Selected vibe text should be nil")
    }

    func test_selectedVibeText_storedToday() {

        let (sut, store) = makeSUT()
        store.store(.chill, timeStamp: { Date()})

        sut.load()

        XCTAssertEqual(sut.selectedVibeText, "Your vibe for today is: \(Vibe.chill.rawValue)")
    }

    func test_selectedVibeText_storedTwoDaysBack() {

        let (sut, store) = makeSUT()
        let storedDate = Date().getDate(byAdding: -3)
        store.store(.chill, timeStamp: { storedDate })

        sut.load()

        XCTAssertEqual(sut.selectedVibeText, "Your vibe for \(storedDate.formattedDate()) is: \(Vibe.chill.rawValue)")
    }

    func test_selectedVibeText_storedTwoVibeBackToBackOnTwoDay() {

        let (sut, store) = makeSUT()
        let storedDate1 = Date()
        let storedDate2 = storedDate1.getDate(byAdding: -1)
        store.store(.focus, timeStamp: { storedDate2 })
        store.store(.chill, timeStamp: { storedDate1 })

        sut.load()

        XCTAssertEqual(sut.selectedVibeText, "Your vibe for today is: \(Vibe.chill.rawValue)")
    }

    func test_selectedVibeText_storedVibeFewDaysBack() {
        let (sut, store) = makeSUT()
        let threeDays = Date().getDate(byAdding: -3)
        let fourDays = threeDays.getDate(byAdding: -1)
        store.store(.power, timeStamp: { threeDays })
        store.store(.chill, timeStamp: { fourDays })

        sut.load()

        XCTAssertEqual(sut.selectedVibeText, "Your vibe for \(threeDays.formattedDate()) is: \(Vibe.power.rawValue)")
    }

    // MARK: - Helpers
    private func makeSUT() -> (sut: VibeViewModel, store: VibeStoreProtocol) {
        let vibeStoreMock = VibeStoreMock()
        return (VibeViewModel(vibeStore: vibeStoreMock), vibeStoreMock)
    }

    private class VibeStoreMock: VibeStoreProtocol {
        var vibeCount: Int {
            selectedVibe.count
        }
        private(set) var selectedVibe: [SelectedVibes] = []

        func store(_ vibe: Vibe, timeStamp: () -> Date) {
            selectedVibe.append(SelectedVibes(vibe: vibe, timeStamp: timeStamp()))
        }
        
        func vibes() -> [TappSampleProject.SelectedVibes]? {
            selectedVibe
        }
        
        var count: Int {
            vibeCount
        }
    }
}


extension Date {
    func getDate(byAdding day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
}
