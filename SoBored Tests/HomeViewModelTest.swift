//
//  HomeViewModelTest.swift
//  SoBored Tests
//
//  Created by Yash Shah on 08/08/2023.
//

import XCTest
@testable import SoBored

final class HomeViewModelTest: XCTestCase {

	func test_fetchRandom_activityNotNil_and_errorNil_whenNetworkRequestSuccessful() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .success(.example1))
		let homeViewModel = HomeViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(homeViewModel.error, "HomeViewModel.error must not be nil before fetchRandom() called")
		XCTAssertNil(homeViewModel.activity, "HomeViewModel.activity must not be nil before fetchRandom() called")

		await homeViewModel.fetchRandom()

		XCTAssertNil(homeViewModel.error, "HomeViewModel.error must be nil")
		let unwrapped = try XCTUnwrap(homeViewModel.activity, "HomeViewModel.activity must not be nil")
		XCTAssertEqual(unwrapped, .example1)
	}

	func test_fetchRandom_activityNil_and_invalidURLError_whenNetworkRequestFails() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .failure(.invalidURL))
		let homeViewModel = HomeViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(homeViewModel.error, "HomeViewModel.error must not be nil before fetchRandom() called")
		XCTAssertNil(homeViewModel.activity, "HomeViewModel.activity must not be nil before fetchRandom() called")

		await homeViewModel.fetchRandom()

		XCTAssertNil(homeViewModel.activity, "HomeViewModel.activity must be nil")
		let unwrapped = try XCTUnwrap(homeViewModel.error, "HomeViewModel.error must no be nil")
		XCTAssertEqual(unwrapped, .invalidURL)
	}

	func test_fetchRandom_activityNil_and_invalidStatusCode404Error_whenNetworkRequestFails() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .failure(.invalidStatusCode(statusCode: 404)))
		let homeViewModel = HomeViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(homeViewModel.error, "HomeViewModel.error must not be nil before fetchRandom() called")
		XCTAssertNil(homeViewModel.activity, "HomeViewModel.activity must not be nil before fetchRandom() called")

		await homeViewModel.fetchRandom()

		XCTAssertNil(homeViewModel.activity, "HomeViewModel.activity must be nil")
		let unwrapped = try XCTUnwrap(homeViewModel.error, "HomeViewModel.error must no be nil")
		XCTAssertEqual(unwrapped, .invalidStatusCode(statusCode: 404))
	}

	func test_fetchRandom_activityNil_and_failedToDecodeError_whenNetworkRequestFails() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .failure(.failedToDecode))
		let homeViewModel = HomeViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(homeViewModel.error, "HomeViewModel.error must not be nil before fetchRandom() called")
		XCTAssertNil(homeViewModel.activity, "HomeViewModel.activity must not be nil before fetchRandom() called")

		await homeViewModel.fetchRandom()

		XCTAssertNil(homeViewModel.activity, "HomeViewModel.activity must be nil")
		let unwrapped = try XCTUnwrap(homeViewModel.error, "HomeViewModel.error must no be nil")
		XCTAssertEqual(unwrapped, .failedToDecode)
	}

	func test_fetchRandom_activityNil_and_customError_whenNetworkRequestFails() async throws {
		let mockNetworkingManager = MockNetworkingManager(result: .failure(.custom(CustomError.someError)))
		let homeViewModel = HomeViewModel(networkingManager: mockNetworkingManager)

		XCTAssertNil(homeViewModel.error, "HomeViewModel.error must not be nil before fetchRandom() called")
		XCTAssertNil(homeViewModel.activity, "HomeViewModel.activity must not be nil before fetchRandom() called")

		await homeViewModel.fetchRandom()

		XCTAssertNil(homeViewModel.activity, "HomeViewModel.activity must be nil")
		let unwrapped = try XCTUnwrap(homeViewModel.error, "HomeViewModel.error must no be nil")
		XCTAssertEqual(unwrapped, .custom(CustomError.someError))
	}

}
