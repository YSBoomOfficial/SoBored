//
//  QueryType.swift
//  SoBored
//
//  Created by Yash Shah on 06/10/2022.
//

import Foundation

enum QueryType {
    case type(ActivityItem.ActivityType)
    case participants(Int)
    case cost(ActivityItem.Cost)
    case accessibility(ActivityItem.AccessibilityLevel)
    
    var queryItems: [String: String] {
#warning("TODO: Implement, min & max for `participants`. RE: Backend")
#warning("TODO: Implement, `containsLink`/`hasLink` query param. RE: Backend")
        
        switch self {
        case .type(let activityType):
            switch activityType {
            case .unspecified: return [:]
            default: return ["type": activityType.rawValue]
            }
        case .participants(let people):
            return people > 0 ? ["participants": "\(people)"] : [:]
        case .cost(let cost):
            switch cost {
            case .unspecified: return [:]
            case .free: return ["price": "0"]
            case .low: return ["minPrice": "0.1", "maxPrice": "0.4"]
            case .medium: return ["minPrice": "0.4", "maxPrice": "0.7"]
            case .high: return ["minPrice": "0.7", "maxPrice": "1"]
            }
        case .accessibility(let accessibility):
            switch accessibility {
            case .unspecified: return [:]
            case .easy: return ["minAccessibility": "0", "maxAccessibility": "0.3"]
            case .medium: return ["minAccessibility": "0.3", "maxAccessibility": "0.6"]
            case .hard: return ["minAccessibility": "0.6", "maxAccessibility": "1"]
            }
        }
    }
}
