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

    func test_request_returnsSuccessfulResponse() async throws {
		let data = try! JSONEncoder().encode(ActivityItem.example2)

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
			let result: ActivityItem = try await NetworkingManager.shared.request(session: session, url)

            XCTAssertEqual(result, ActivityItem.example2, "Decoded Data and Example Data should be the same")
        } catch {
            XCTFail("NetworkingManager should not throw error")
        }
    }

	func test_request_throwsInvalidURLError_whenURLInvalid() async throws {
        do {
			let _: ActivityItem = try await NetworkingManager.shared.request(session: session, nil)
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

    func test_request_throwsInvalidStatusCodeError_whenAPIReturns404StatusCode() async throws {
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
            let _: ActivityItem = try await NetworkingManager.shared.request(session: session, url)
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

    func test_request_throwsInvalidStatusCodeError_whenAPIReturnsUnknownStatusCode() async throws {
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
			let _: ActivityItem = try await NetworkingManager.shared.request(session: session, url)
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

    func test_request_throwsFailedToDecodeError_whenDecodingAPIResponseFails() async throws {
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
			let _: ActivityItem = try await NetworkingManager.shared.request(session: session, url)
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
