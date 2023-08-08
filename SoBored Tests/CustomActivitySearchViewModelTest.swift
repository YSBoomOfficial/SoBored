//
//  CustomActivitySearchViewModelTest.swift
//  SoBored Tests
//
//  Created by Yash Shah on 08/08/2023.
//

import Foundation

import XCTest
@testable import SoBored

final class CustomActivitySearchViewModelTest: XCTestCase {

	func test_fetch_activityNotNil_and_errorNil_whenNetworkRequestSuccessful() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .success(.example1))
		let customActivitySearchViewModel = CustomActivitySearchViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must not be nil before fetch() called")
		XCTAssertNil(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must not be nil before fetch() called")

		await customActivitySearchViewModel.fetch()

		XCTAssertNil(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must be nil")
		let unwrapped = try XCTUnwrap(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must not be nil")
		XCTAssertEqual(unwrapped, .example1)
	}

	func test_fetch_activityNil_and_invalidURLError_whenNetworkRequestFails() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .failure(.invalidURL))
		let customActivitySearchViewModel = CustomActivitySearchViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must not be nil before fetch() called")
		XCTAssertNil(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must not be nil before fetch() called")

		await customActivitySearchViewModel.fetch()

		XCTAssertNil(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must be nil")
		let unwrapped = try XCTUnwrap(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must no be nil")
		XCTAssertEqual(unwrapped, .invalidURL)
	}

	func test_fetch_activityNil_and_invalidStatusCode404Error_whenNetworkRequestFails() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .failure(.invalidStatusCode(statusCode: 404)))
		let customActivitySearchViewModel = CustomActivitySearchViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must not be nil before fetch() called")
		XCTAssertNil(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must not be nil before fetch() called")

		await customActivitySearchViewModel.fetch()

		XCTAssertNil(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must be nil")
		let unwrapped = try XCTUnwrap(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must no be nil")
		XCTAssertEqual(unwrapped, .invalidStatusCode(statusCode: 404))
	}

	func test_fetch_activityNil_and_failedToDecodeError_whenNetworkRequestFails() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .failure(.failedToDecode))
		let customActivitySearchViewModel = CustomActivitySearchViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must not be nil before fetch() called")
		XCTAssertNil(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must not be nil before fetch() called")

		await customActivitySearchViewModel.fetch()

		XCTAssertNil(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must be nil")
		let unwrapped = try XCTUnwrap(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must no be nil")
		XCTAssertEqual(unwrapped, .failedToDecode)
	}

	func test_fetch_activityNil_and_customError_whenNetworkRequestFails() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .failure(.custom(CustomError.someError)))
		let customActivitySearchViewModel = CustomActivitySearchViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must not be nil before fetch() called")
		XCTAssertNil(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must not be nil before fetch() called")

		await customActivitySearchViewModel.fetch()

		XCTAssertNil(customActivitySearchViewModel.activity, "CustomActivitySearchViewModel.activity must be nil")
		let unwrapped = try XCTUnwrap(customActivitySearchViewModel.error, "CustomActivitySearchViewModel.error must no be nil")
		XCTAssertEqual(unwrapped, .custom(CustomError.someError))
	}

}
