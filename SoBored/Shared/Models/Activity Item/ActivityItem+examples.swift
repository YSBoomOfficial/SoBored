//
//  ActivityItem+examples.swift
//  SoBored
//
//  Created by Yash Shah on 05/11/2022.
//

import Foundation

// MARK: ActivityItem + examples
extension ActivityItem {
	static let examples: [ActivityItem] = [example1, .example2]

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
