//
//  CustomActivitySearchViewModel.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import Foundation

final class CustomActivitySearchViewModel: ObservableObject {
	@Published private(set) var activity: ActivityItem?

	@Published var activityType: ActivityItem.ActivityType = .education
	@Published var participants = 1.0
	@Published var activityCost: ActivityItem.Cost = .free
	@Published var accessibilityLevel: ActivityItem.AccessibilityLevel = .easy
	@Published var error: Error? = nil

	@MainActor
	func fetch() async {
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

		do {
			let url = builder.build()
			print(url?.absoluteString ?? "NO URL")
			print(builder.requestQueryItems)
			activity = try await NetworkingManager.shared.request(url, type: ActivityItem.self)
			error = nil
		} catch {
			print("\n\n")
			print(error.localizedDescription)
			print("\n\n")
			activity = nil
			self.error = error
		}
	}
	
}
