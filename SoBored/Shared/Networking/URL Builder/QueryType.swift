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
    case cost(ActivityItem.Cost)
    case accessibility(ActivityItem.AccessibilityLevel)

    var queryItems: [String: String] {
        switch self {
            case .id(let id): return ["key": id]
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
                    case .low: return ["minprice": "0.1", "maxprice": "0.4"]
                    case .medium: return ["minprice": "0.4", "maxprice": "0.7"]
                    case .high: return ["minprice": "0.7", "maxprice": "1"]
                }
            case .accessibility(let accessibility):
                switch accessibility {
                    case .unspecified: return [:]
                    case .easy: return ["minaccessibility": "0", "maxaccessibility": "0.3"]
                    case .medium: return ["minaccessibility": "0.3", "maxaccessibility": "0.6"]
                    case .hard: return ["minaccessibility": "0.6", "maxaccessibility": "1"]
                }
        }
    }
}
