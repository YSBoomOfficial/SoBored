//
//  ActivityItem+Cost.swift
//  SoBored
//
//  Created by Yash Shah on 05/11/2022.
//

import Foundation

// MARK: ActivityItem + Cost
extension ActivityItem {
    enum Cost: String, CaseIterable, Identifiable {
        var id: String { rawValue }

        case unspecified = "any"
        case free, low, medium, high

        var title: String {
            rawValue.capitalized
        }
    }

    var cost: Cost {
        switch price {
            case 0: return .free
            case 0.1..<0.4: return .low
            case 0.4..<0.7: return .medium
            default: return .unspecified
        }
    }
}
