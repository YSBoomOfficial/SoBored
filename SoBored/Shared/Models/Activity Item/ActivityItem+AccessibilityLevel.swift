//
//  ActivityItem+AccessibilityLevel.swift
//  SoBored
//
//  Created by Yash Shah on 05/11/2022.
//

import Foundation

// MARK: ActivityItem + AccessibilityLevel
extension ActivityItem {
    enum AccessibilityLevel: String, CaseIterable, Identifiable {
        var id: String { rawValue }

        case unspecified = "any"
        case easy, medium, hard

        var title: String {
            rawValue.capitalized
        }
    }

    var accessibilityLevel: AccessibilityLevel {
        switch accessibility {
            case 0...0.3: return .easy
            case 0.3...0.6: return .medium
            case 0.6...1: return .hard
            default: return .unspecified
        }
    }
}

