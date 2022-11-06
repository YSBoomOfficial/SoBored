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

            XCTAssertEqual(result, ActivityItem.example2, "Decoded Data and Example Data should be the same")
        } catch {
            XCTFail("NetworkingManager should not throw error")
        }
    }

    func test_network_manager_failure_invalidURL_error_thrown() async throws {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: URL(string: "")!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )

            return (response!, nil)
        }

        do {
            _ = try await NetworkingManager.shared.request(
                session: session,
                URL(string: ""),
                type: ActivityItem.self
            )
        } catch {
            guard let err = error as? NetworkingError else {
                XCTFail("Should be NetworkingError")
                return
            }

            XCTAssertEqual(err, .invalidURL, "invalidURL Error Should be thrown")
            XCTAssertEqual(err.errorDescription, "The URL is invalid.", "incorrect error message shown")
            return
        }

        XCTFail("Should not skip catch block")
    }

    func test_network_manager_failure_invalidStatusCode_404_error_thrown() async throws {
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

            XCTAssertEqual(err, .invalidStatusCode(statusCode: 404), "invalidStatusCode 404 error should be thrown")
            XCTAssertEqual(err.errorDescription, "No activity found with the specified parameters", "incorrect error message shown")
            return
        }

        XCTFail("Should not skip catch block")
    }

    func test_network_manager_failure_invalidStatusCode_error_thrown() async throws {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.url,
                statusCode: 0,
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

            XCTAssertEqual(err, .invalidStatusCode(statusCode: 0), "invalidStatusCode error should be thrown")
            XCTAssertEqual(err.errorDescription, "The server returned an invalid status code. 'Status Code: 0'", "incorrect error message shown")
            return
        }

        XCTFail("Should not skip catch block")
    }

    func test_network_manager_failure_failedToDecode_error_thrown() async throws {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )

            return (response!, Data())
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

            XCTAssertEqual(err, .failedToDecode, "failedToDecode error should be thrown")
            XCTAssertEqual(err.errorDescription, "No activity found with the specified parameters", "incorrect error message shown")
            return
        }

        XCTFail("Should not skip catch block")
    }
}
