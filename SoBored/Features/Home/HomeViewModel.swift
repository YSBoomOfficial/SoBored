//
//  HomeViewModel.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import Foundation

final class HomeViewModel: ObservableObject {
	@Published private(set) var activity: ActivityItem?
	@Published var error: Error? = nil

	@MainActor
	func fetchRandom() async {
		do {
			activity = try await NetworkingManager.shared.request(URL(string: "https://www.boredapi.com/api/activity/"), type: ActivityItem.self)
			error = nil 
		} catch {
			print(error.localizedDescription)
			activity = nil
			self.error = error
		}
	}
}
