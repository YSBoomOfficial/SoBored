//
//  ActivityItem+ActivityType.swift
//  SoBored
//
//  Created by Yash Shah on 05/11/2022.
//

import Foundation

// MARK: ActivityItem + ActivityType
extension ActivityItem {
    enum ActivityType: String, Codable, CaseIterable, Identifiable {
        var id: String { rawValue }

        case unspecified = "any"
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
                default: return rawValue.capitalized
            }
        }

        var symbol: String {
            switch self {
                case .unspecified: return "questionmark.circle"
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
