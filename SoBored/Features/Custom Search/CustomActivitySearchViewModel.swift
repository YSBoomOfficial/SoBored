//
//  CustomActivitySearchViewModel.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import Foundation

final class CustomActivitySearchViewModel: ObservableObject {
	@Published private(set) var activity: ActivityItem?
    @Published private(set) var error: NetworkingError? = nil

    @Published var activityType: ActivityItem.ActivityType = .unspecified
    @Published var participants: Double = 0
    @Published var activityCost: ActivityItem.Cost = .unspecified
    @Published var accessibilityLevel: ActivityItem.AccessibilityLevel = .unspecified

    var isEqualToBaseURL: Bool {
        activityType == .unspecified && participants == 0 && activityCost == .unspecified && accessibilityLevel == .unspecified
    }

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
            if let err = error as? NetworkingError {
                self.error = err
            } else {
                self.error = .custom(error)
            }
		}
	}

    private func buildURL() -> URL? {
        guard !isEqualToBaseURL else { return URLBuilder.baseURL }

        return URLBuilder()
            .appending(query: .type(activityType))
            .appending(query: .participants(Int(participants)))
            .appending(query: .cost(activityCost))
            .appending(query: .accessibility(accessibilityLevel))
            .build()
    }
	
}
