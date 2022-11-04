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

// MARK: ActivityItem + ActivityType
extension ActivityItem {
	enum ActivityType: String, Codable, CaseIterable, Identifiable {
		var id: String { rawValue }

		case education = "education"
		case recreational = "recreational"
		case social = "social"
		case diy = "diy"
		case charity = "charity"
		case cooking = "cooking"
		case relaxation = "relaxation"
		case music = "music"
		case busywork = "busywork"

		var title: String {
			switch self {
				case .diy: return "DIY"
				default: return self.rawValue.capitalized
			}
		}

		var symbol: String {
			switch self {
				case .education: return "graduationcap.fill"
				case .recreational: return "books.vertical.fill"
				case .social: return "person.3.sequence.fill"
				case .diy: return "hammer.fill"
				case .charity: return "peacesign"
				case .cooking: return "fork.knife"
				case .relaxation: return "bed.double.fill"
				case .music: return "music.quarternote.3"
				case .busywork: return "square.and.pencil"
			}
		}
	}
}

// MARK: ActivityItem + Cost
extension ActivityItem {
	enum Cost: String, CaseIterable, Identifiable {
		var id: String { rawValue }

		case free, low, medium, high
	}

	var cost: Cost {
		switch price {
			case 0: return .free
			case 0.1..<0.3: return .low
			case 0.3..<0.6: return .medium
			default: return .high
		}
	}
}

// MARK: ActivityItem + Accessibility
extension ActivityItem {
	enum AccessibilityLevel: String, CaseIterable, Identifiable {
		var id: String { rawValue }

		case easy, medium, hard
	}

	var accessibilityLevel: AccessibilityLevel {
		switch accessibility {
			case 0..<0.3: return .easy
			case 0.3..<0.6: return .medium
			default: return .hard
		}
	}
}

// MARK: ActivityItem + activityURL
extension ActivityItem {
	var activityURL: URL? {
		guard !link.isEmpty else { return nil }
		return URL(string: link)
	}
}


extension ActivityItem {
	static let example1 = ActivityItem(
		key: "4981819",
        activity: "Find a DIY to do",
		type: .diy,
		participants: 1,
		price: 0.4,
		accessibility: 0.3,
		link: ""
	)

	static let example2 = ActivityItem(
		key: "8264223",
        activity: "Learn how to use an Arduino",
		type: .education,
		participants: 1,
		price: 0.1,
		accessibility: 0.7,
		link: "https://en.wikipedia.org/wiki/Arduino"
	)
}
