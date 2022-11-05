//
//  ActivityItem.swift
//  SoBored
//
//  Created by Yash Shah on 05/10/2022.
//

import Foundation

// MARK: ActivityItem Base Model
struct ActivityItem: Codable, Identifiable, Equatable {
	var id: String { key }
	
	/// A unique numeric id
	///
	/// - Range: [1000000, 9999999]
	let key: String

	/// Description of the activity
	let activity: String

	/// Type of the activity
	let type: ActivityType

	/// The number of people that this activity could involve
	///
	/// - Range: [0, n]
	let participants: Int

	/// A factor describing the cost of the event.
	///
	/// - Range: [0, 1] with 0 being free and 1 being expensive
	let price: Double

	/// A factor describing how possible an event is to do.
	///
	/// - Range: [0.0, 1.0] with zero being the most accessible
	let accessibility: Double

	/// A link to the event
	let link: String

}

// MARK: ActivityItem + activityURL
extension ActivityItem {
    var activityURL: URL? {
        guard !link.isEmpty else { return nil }
        return URL(string: link)
    }
}
