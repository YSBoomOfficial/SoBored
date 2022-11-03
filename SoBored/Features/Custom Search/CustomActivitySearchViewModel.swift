//
//  CustomActivitySearchViewModel.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import Foundation

final class CustomActivitySearchViewModel: ObservableObject {
	@Published private(set) var activity: ActivityItem?
    @Published private(set) var error: NetworkingManager.NetworkingError? = nil

    @Published var activityType: ActivityItem.ActivityType = .education
    @Published var participants = 1.0
    @Published var activityCost: ActivityItem.Cost = .free
    @Published var accessibilityLevel: ActivityItem.AccessibilityLevel = .easy

	@MainActor
	func fetch() async {
		do {
			let url = buildURL()
			print(url?.absoluteString ?? "NO URL")
            print(url?.pathComponents ?? "NO PATH COMPONENTS")

			activity = try await NetworkingManager.shared.request(
                url,
                type: ActivityItem.self
            )
			error = nil
		} catch {
            activity = nil
            print(error.localizedDescription)
            if let err = error as? NetworkingManager.NetworkingError {
                self.error = err
            } else {
                self.error = .custom(error)
            }
		}
	}

    private func buildURL() -> URL? {
        let builder = URLBuilder()
        builder
            .appending(query: .type(activityType))
            .appending(query: .participants(Int(participants)))

        switch activityCost {
            case .free: builder.appending(query: .price(0))
            case .low: builder.appending(query: .priceRange(0.1...0.3))
            case .medium: builder.appending(query: .priceRange(0.3...0.6))
            case .high: builder.appending(query: .priceRange(0.6...1))
        }

        switch accessibilityLevel {
            case .easy: builder.appending(query: .priceRange(0...0.3))
            case .medium: builder.appending(query: .priceRange(0.3...0.6))
            case .hard: builder.appending(query: .priceRange(0.3...1))
        }

        return builder.build()
    }
	
}
