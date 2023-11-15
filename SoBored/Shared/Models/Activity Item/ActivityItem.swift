//
//  ActivityItem.swift
//  SoBored
//
//  Created by Yash Shah on 05/10/2022.
//

import Foundation

// MARK: ActivityItem Base Model
struct ActivityItem: Codable, Identifiable, Equatable {
    
    /// A unique identifier representing the ID
    var id: UUID

    /// Description of the activity
    var activity: String
    
    /// Type of the activity
    var type: ActivityType
    
    /// The number of people that this activity could involve
    ///
    /// - Range: [0, n]
    var participants: Int
    
    /// A factor describing the cost of the event.
    ///
    /// - Range: [0, 1] with 0 being free and 1 being expensive
    var price: Double
    
    /// A factor describing how possible an event is to do.
    ///
    /// - Range: [0.0, 1.0] with zero being the most accessible
    var accessibility: Double
    
    /// A link relating to the activity
    var link: String?
    
    init(
        id: UUID,
        activity: String,
        type: ActivityType,
        participants: Int,
        price: Double,
        accessibility: Double,
        link: String? = nil
    ) {
        self.id = id
        self.activity = activity
        self.type = type
        self.participants = participants
        self.price = price
        self.accessibility = accessibility
        self.link = link
    }

}

// MARK: ActivityItem + activityURL
extension ActivityItem {
    var activityURL: URL? {
        guard let link else { return nil }
        return URL(string: link)
    }
    
    var simplifiedURLString: String? {
        guard let link else { return nil }
        return link
            .trimmingPrefix("http://")
            .trimmingPrefix("https://")
            .trimmingPrefix("www.")
            .trimmingSuffix("/")
    }
}
