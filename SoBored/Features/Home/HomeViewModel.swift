//
//  HomeViewModel.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import Foundation

final class HomeViewModel: ObservableObject {
	@Published private(set) var activity: ActivityItem?
    @Published private(set) var error: NetworkingError? = nil

	@MainActor
	func fetchRandom() async {
		do {
			activity = try await NetworkingManager.shared.request(
                URLBuilder.baseURL,
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
}
