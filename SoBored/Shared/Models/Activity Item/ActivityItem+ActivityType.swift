//
//  ActivityItem+ActivityType.swift
//  SoBored
//
//  Created by Yash Shah on 05/11/2022.
//

import Foundation

// MARK: ActivityItem + ActivityType
extension ActivityItem {
    enum ActivityType: RawRepresentable, Codable, CaseIterable, Identifiable {
        var id: String { rawValue }
        
        case education
        case recreational
        case social
        case diy
        case charity
        case cooking
        case relaxation
        case music
        case busywork
        case unspecified
        
        init?(rawValue: String) {
            switch rawValue.lowercased() {
            case "education": self = .education
            case "recreational": self = .recreational
            case "social": self = .social
            case "diy": self = .diy
            case "charity": self = .charity
            case "cooking": self = .cooking
            case "relaxation": self = .relaxation
            case "music": self = .music
            case "busywork": self = .busywork
            default: self = .unspecified
            }
        }
        
        var rawValue: String {
            switch self {
            case .education: "education"
            case .recreational: "recreational"
            case .social: "social"
            case .diy: "diy"
            case .charity: "charity"
            case .cooking: "cooking"
            case .relaxation: "relaxation"
            case .music: "music"
            case .busywork: "busywork"
            case .unspecified: "any"
            }
        }
        
        var title: String {
            switch self {
            case .diy: return "DIY"
            default: return rawValue.capitalized
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
            case .unspecified: return "questionmark.circle"
            }
        }
    }
}
