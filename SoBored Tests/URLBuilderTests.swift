//
//  URLBuilderTests.swift
//  SoBored Tests
//
//  Created by Yash Shah on 06/11/2022.
//

import XCTest
@testable import SoBored

final class URLBuilderTests: XCTestCase {

    func test_baseURL_isCorrect() {
        let builderURLBase = URLBuilder.baseURL
        let testURLBase = makeURL()

        XCTAssertNotNil(builderURLBase, "Builder URL (Base URL) Should not be nil")
        XCTAssertNotNil(testURLBase, "Test URL (Base URL) Should not be nil")

        XCTAssertEqual(builderURLBase, testURLBase, "URLBuilder's url and and the helper function should return the same URL (Base URL)")
    }

    func test_build_returnsCorrectURL_for_ActivityItem_ID() {
        let builderURLActivityID = URLBuilder()
            .appending(query: .id(ActivityItem.example2.id))
            .build()

        let testURLActivityID = makeURL(
            withQueryParameters: ["key": ActivityItem.example2.key]
        )

        XCTAssertNotNil(builderURLActivityID, "Builder URL (ActivityID) Should not be nil")
        XCTAssertNotNil(testURLActivityID, "Test URL (ActivityID) Should not be nil")

        XCTAssertEqual(builderURLActivityID, testURLActivityID, "URLBuilder's url and and the helper function should return the same URL (ActivityID)")
    }

    func test_build_returnsCorrectURL_for_ActivityItem_ActivityType() {
        let builderURLActivityTypeUnspecified = URLBuilder()
            .appending(query: .type(.unspecified))
            .build()

        let testURLActivityTypeUnspecified = makeURL()

        XCTAssertNotNil(builderURLActivityTypeUnspecified, "Builder URL (ActivityTypeUnspecified) Should not be nil")
        XCTAssertNotNil(testURLActivityTypeUnspecified, "Test URL (ActivityTypeUnspecified) Should not be nil")

        XCTAssertEqual(builderURLActivityTypeUnspecified, testURLActivityTypeUnspecified, "URLBuilder's url and and the helper function should return the same URL (ActivityTypeUnspecified)")

        for type in ActivityItem.ActivityType.allCases where type != .unspecified {
            let builderURLActivityType = URLBuilder()
                .appending(query: .type(type))
                .build()

            let testURLActivityType = makeURL(
                withQueryParameters: ["type": type.rawValue]
            )

            XCTAssertNotNil(builderURLActivityType, "Builder URL (ActivityType) Should not be nil")
            XCTAssertNotNil(testURLActivityType, "Test (ActivityType) URL Should not be nil")

            XCTAssertEqual(builderURLActivityType, testURLActivityType, "URLBuilder's url and and the helper function should return the same URL (ActivityType)")
        }

    }

    func test_build_returnsCorrectURL_for_ActivityItem_participants() {
        // MARK: Unspecified number of Participants (0)
        let builderURLParticipantsUnspecified  = URLBuilder()
            .appending(query: .participants(0))
            .build()

        let testURLParticipantsUnspecified = makeURL()

        XCTAssertNotNil(builderURLParticipantsUnspecified, "Builder URL (ParticipantsUnspecified) Should not be nil")
        XCTAssertNotNil(testURLParticipantsUnspecified, "Test URL (ParticipantsUnspecified) Should not be nil")

        XCTAssertEqual(builderURLParticipantsUnspecified, testURLParticipantsUnspecified, "URLBuilder's url and and the helper function should return the same URL (ParticipantsUnspecified)")

        // MARK: Specified number of Participants (1 or more)
        let builderURLParticipants = URLBuilder()
            .appending(query: .participants(2))
            .build()

        let testURLParticipants = makeURL(
            withQueryParameters: ["participants": "2"]
        )

        XCTAssertNotNil(builderURLParticipants, "Builder URL (Participants) Should not be nil")
        XCTAssertNotNil(testURLParticipants, "Test URL (Participants) Should not be nil")

        XCTAssertEqual(builderURLParticipants, testURLParticipants, "URLBuilder's url and and the helper function should return the same URL (Participants)")
    }

    func test_build_returnsCorrectURL_for_ActivityItem_Cost() {
        // MARK: Activity Cost Unspecified
        let builderURLActivityCostUnspecified = URLBuilder()
            .appending(query: .cost(.unspecified))
            .build()

        let testURLActivityCostUnspecified = makeURL()

        XCTAssertNotNil(builderURLActivityCostUnspecified, "Builder URL (ActivityCostUnspecified) Should not be nil")
        XCTAssertNotNil(testURLActivityCostUnspecified, "Test URL (ActivityCostUnspecified) Should not be nil")

        XCTAssertEqual(builderURLActivityCostUnspecified, testURLActivityCostUnspecified, "URLBuilder's url and and the helper function should return the same URL (ActivityCostUnspecified)")

        // MARK: Activity Cost Free
        let builderURLActivityCostFree = URLBuilder()
            .appending(query: .cost(.free))
            .build()

        let testURLActivityCostFree = makeURL(
            withQueryParameters: ["price": "0"]
        )

        XCTAssertNotNil(builderURLActivityCostFree, "Builder URL (ActivityCostFree) Should not be nil")
        XCTAssertNotNil(testURLActivityCostFree, "Test URL (ActivityCostFree) Should not be nil")

        XCTAssertEqual(builderURLActivityCostFree, testURLActivityCostFree, "URLBuilder's url and and the helper function should return the same URL (ActivityCostFree)")

        // MARK: Activity Cost Low
        let builderURLActivityCostLow = URLBuilder()
            .appending(query: .cost(.low))
            .build()

        let testURLActivityCostLow = makeURL(
            withQueryParameters: [
                "minprice": "0.1",
                "maxprice": "0.4"
            ]
        )

        XCTAssertNotNil(builderURLActivityCostLow, "Builder URL (ActivityCostLow) Should not be nil")
        XCTAssertNotNil(testURLActivityCostLow, "Test URL (ActivityCostLow) Should not be nil")

        XCTAssertEqual(builderURLActivityCostLow, testURLActivityCostLow, "URLBuilder's url and and the helper function should return the same URL (ActivityCostLow)")

        // MARK: Activity Cost Medium
        let builderURLActivityCostMedium = URLBuilder()
            .appending(query: .cost(.medium))
            .build()

        let testURLActivityCostMedium = makeURL(
            withQueryParameters: [
                "minprice": "0.4",
                "maxprice": "0.7"
            ]
        )

        XCTAssertNotNil(builderURLActivityCostMedium, "Builder URL (ActivityCostMedium) Should not be nil")
        XCTAssertNotNil(testURLActivityCostMedium, "Test URL (ActivityCostMedium) Should not be nil")

        XCTAssertEqual(builderURLActivityCostMedium, testURLActivityCostMedium, "URLBuilder's url and and the helper function should return the same URL (ActivityCostMedium)")

        // MARK: Activity Cost High
        let builderURLActivityCostHigh = URLBuilder()
            .appending(query: .cost(.high))
            .build()

        let testURLActivityCostHigh = makeURL(
            withQueryParameters: [
                "minprice": "0.7",
                "maxprice": "1"
            ]
        )

        XCTAssertNotNil(builderURLActivityCostHigh, "Builder URL (ActivityCostHigh) Should not be nil")
        XCTAssertNotNil(testURLActivityCostHigh, "Test URL (ActivityCostHigh) Should not be nil")

        XCTAssertEqual(builderURLActivityCostHigh, testURLActivityCostHigh, "URLBuilder's url and and the helper function should return the same URL (ActivityCostHigh)")

    }

    func test_build_returnsCorrectURL_for_ActivityItem_AccessibilityLevel() {
        // MARK: Activity AccessibilityLevel Unspecified
        let builderURLActivityAccessibilityLevelUnspecified = URLBuilder()
            .appending(query: .accessibility(.unspecified))
            .build()

        let testURLActivityAccessibilityLevelUnspecified = makeURL()

        XCTAssertNotNil(builderURLActivityAccessibilityLevelUnspecified, "Builder URL (ActivityAccessibilityLevelUnspecified) Should not be nil")
        XCTAssertNotNil(testURLActivityAccessibilityLevelUnspecified, "Test URL (ActivityAccessibilityLevelUnspecified) Should not be nil")

        XCTAssertEqual(builderURLActivityAccessibilityLevelUnspecified, testURLActivityAccessibilityLevelUnspecified, "URLBuilder's url and and the helper function should return the same URL (ActivityAccessibilityLevelUnspecified)")

        // MARK: Activity AccessibilityLevel Easy
        let builderURLActivityAccessibilityLevelEasy = URLBuilder()
            .appending(query: .accessibility(.easy))
            .build()

        let testURLActivityAccessibilityLevelEasy = makeURL(
            withQueryParameters: [
                "minaccessibility": "0",
                "maxaccessibility": "0.3"
            ]
        )

        XCTAssertNotNil(builderURLActivityAccessibilityLevelEasy, "Builder URL (ActivityAccessibilityLevelEasy) Should not be nil")
        XCTAssertNotNil(testURLActivityAccessibilityLevelEasy, "Test URL (ActivityAccessibilityLevelEasy) Should not be nil")

        XCTAssertEqual(builderURLActivityAccessibilityLevelEasy, testURLActivityAccessibilityLevelEasy, "URLBuilder's url and and the helper function should return the same URL (ActivityAccessibilityLevelEasy)")

        // MARK: Activity AccessibilityLevel Medium
        let builderURLActivityAccessibilityLevelMedium = URLBuilder()
            .appending(query: .accessibility(.medium))
            .build()

        let testURLActivityAccessibilityLevelMedium = makeURL(
            withQueryParameters: [
                "minaccessibility": "0.3",
                "maxaccessibility": "0.6"
            ]
        )

        XCTAssertNotNil(builderURLActivityAccessibilityLevelMedium, "Builder URL (ActivityAccessibilityLevelMedium) Should not be nil")
        XCTAssertNotNil(testURLActivityAccessibilityLevelMedium, "Test URL (ActivityAccessibilityLevelMedium) Should not be nil")

        XCTAssertEqual(builderURLActivityAccessibilityLevelMedium, testURLActivityAccessibilityLevelMedium, "URLBuilder's url and and the helper function should return the same URL (ActivityAccessibilityLevelMedium)")

        // MARK: Activity AccessibilityLevel Hard
        let builderURLActivityAccessibilityLevelHard = URLBuilder()
            .appending(query: .accessibility(.hard))
            .build()

        let testURLActivityAccessibilityLevelMHard = makeURL(
            withQueryParameters: [
                "minaccessibility": "0.6",
                "maxaccessibility": "1"
            ]
        )

        XCTAssertNotNil(builderURLActivityAccessibilityLevelHard, "Builder URL (ActivityAccessibilityLevelHard) Should not be nil")
        XCTAssertNotNil(testURLActivityAccessibilityLevelMHard, "Test URL (ActivityAccessibilityLevelHard) Should not be nil")

        XCTAssertEqual(builderURLActivityAccessibilityLevelHard, testURLActivityAccessibilityLevelMHard, "URLBuilder's url and and the helper function should return the same URL (ActivityAccessibilityLevelHard)")

    }
}

// MARK: makeURL Helper
fileprivate extension URLBuilderTests {
    private func makeURL(withQueryParameters params: [String: String] = [:]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "boredapi.com"
        components.path = "/api/activity"
        if !params.isEmpty {
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        return components.url
    }
}
