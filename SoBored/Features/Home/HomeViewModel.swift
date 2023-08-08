//
//  HomeViewModel.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import Foundation

final class HomeViewModel: ObservableObject {
	private let networkingManager: NetworkingManaging

	@Published private(set) var activity: ActivityItem?
	@Published private(set) var error: NetworkingError?

	init(networkingManager: NetworkingManaging = NetworkingManager.shared) {
		self.networkingManager = networkingManager
	}

	@MainActor
	func fetchRandom() async {
		activity = nil
		error = nil

		do {
			activity = try await networkingManager.request(
				session: .shared,
				URLBuilder.baseURL
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
