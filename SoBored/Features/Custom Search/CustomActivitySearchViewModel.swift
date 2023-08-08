//
//  CustomActivitySearchViewModel.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import Foundation

final class CustomActivitySearchViewModel: ObservableObject {
    private let networkingManager: NetworkingManaging

    @Published private(set) var activity: ActivityItem?
    @Published private(set) var error: NetworkingError?

    @Published var activityType: ActivityItem.ActivityType = .unspecified
    @Published var participants: Double = 0
    @Published var activityCost: ActivityItem.Cost = .unspecified
    @Published var accessibilityLevel: ActivityItem.AccessibilityLevel = .unspecified

    private var isEqualToBaseURL: Bool {
        activityType == .unspecified
        && participants == 0
        && activityCost == .unspecified
        && accessibilityLevel == .unspecified
    }

    init(networkingManager: NetworkingManaging = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }

    @MainActor
    func fetch() async {
		activity = nil
		error = nil

        do {
            let url = buildURL()
            print(url?.absoluteString ?? "NO URL")
            print(url?.pathComponents ?? "NO PATH COMPONENTS")

            activity = try await networkingManager.request(
                session: .shared,
				url
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
