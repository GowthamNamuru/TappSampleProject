//
//  VibeDataProvider.swift
//  TappSampleProject
//
//  Created by Gowtham Namuru on 07/06/25.
//

import Foundation

// As of now we are using UserDefaults, as our usecase is simple, we can migrate to any storage model in future.
final class VibeDataProvider {

    private let store: UserDefaults

    init(_ suiteName: String) {
        store = UserDefaults(suiteName: suiteName) ?? .standard
    }

    func storeVibe(_ vibe: Vibe, timeStamp: () -> Date) {
        // Get previosly stored Vibes with dateStamp
        // add the new vibe along with new timeStamp
        if var previouslyStoredVibes = storedVibes() {
            previouslyStoredVibes.append(SelectedVibes(vibe: vibe, timeStamp: timeStamp()))
            if let dataToStore = encodedVibes(previouslyStoredVibes) {
                // Store all the vibes
                store.set(dataToStore, forKey: Constants.storedVibes)
            }
        } else {
            let vibeToStore = SelectedVibes(vibe: vibe, timeStamp: timeStamp())
            if let dataToStore = encodedVibes([vibeToStore]) {
                // Store all the vibes
                store.set(dataToStore, forKey: Constants.storedVibes)
            }
        }
    }

    func vibes() -> [SelectedVibes]? {
        storedVibes()
    }
}

// MARK: - Constants
private extension VibeDataProvider {
    enum Constants {
        static let storedVibes: String = "storedVibes"
    }
}

// MARK: - Helpers
private extension VibeDataProvider {
    func storedVibes() -> [SelectedVibes]? {
        if let data = store.data(forKey: Constants.storedVibes) {
            return try? JSONDecoder().decode([SelectedVibes].self, from: data)
        }
        return nil
    }

    func encodedVibes(_ vibes: [SelectedVibes]) -> Data? {
        return try? JSONEncoder().encode(vibes)
    }
}
