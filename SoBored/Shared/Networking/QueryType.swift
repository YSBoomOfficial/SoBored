//
//  QueryType.swift
//  SoBored
//
//  Created by Yash Shah on 06/10/2022.
//

import Foundation

enum QueryType {
	case id(ActivityItem.ID)
	case type(ActivityItem.ActivityType)
	case participants(Int)
	case price(Double)
	case priceRange(ClosedRange<Double>)
	case accessibility(Double)
	case accessibilityRange(ClosedRange<Double>)

	 var queryItems: [String: String] {
		switch self {
			case .id(let id):
				return ["key": id]
			case .type(let activityType):
				return ["type": activityType.rawValue]
			case .participants(let people):
				return ["participants": "\(people)"]
			case .price(let price):
				return ["price": "\(price)"]
			case .priceRange(let range):
				let low = range.lowerBound < 0 ? 0 : range.lowerBound
				let high = range.upperBound > 1 ? 1 : range.upperBound
				return ["minprice": "\(low)", "maxprice": "\(high)"]
			case .accessibility(let value):
				return ["accessibility": "\(value)"]
			case .accessibilityRange(let range):
				let low = range.lowerBound < 0 ? 0 : range.lowerBound
				let high = range.upperBound > 1 ? 1 : range.upperBound
				return ["minaccessibility": "\(low)", "maxaccessibility": "\(high)"]
		}
	}
}
