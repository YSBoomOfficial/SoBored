//
//  NetworkingManagerTests.swift
//  SoBored Tests
//
//  Created by Yash Shah on 04/11/2022.
//

import XCTest
@testable import SoBored

final class NetworkingManagerTests: XCTestCase {
    private var session: URLSession!
    private var url: URL!

    override func setUp() {
        super.setUp()
        url = URLBuilder.baseURL
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLSessionProtocol.self]
        session = .init(configuration: config)
    }

    override func tearDown() {
        super.tearDown()
        url = nil
        session = nil
    }

    func test_network_manager_success_returns_correct_response() async throws {
        guard let path = Bundle(for: Self.self).path(forResource: "ActivityItem-example", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("file ActivityItem-example.json not found")
            return
        }

        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )

            return (response!, data)
        }

        do {
            let result = try await NetworkingManager.shared.request(
                session: session,
                url,
                type: ActivityItem.self
            )

            XCTAssertEqual(result, ActivityItem.example2)

        } catch {
            XCTFail("NetworkingManager should not throw error")
        }

    }

    func test_network_manager_throws_correct_error() async throws {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.url,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )

            return (response!, nil)
        }

        do {
            _ = try await NetworkingManager.shared.request(
                session: session,
                url,
                type: ActivityItem.self
            )
        } catch {
            guard let err = error as? NetworkingError else {
                XCTFail("Should be NetworkingError")
                return
            }

            XCTAssertEqual(err.errorDescription, "No activity found with the specified parameters")
            return
        }

        XCTFail("Should not skip catch block")
    }

}
