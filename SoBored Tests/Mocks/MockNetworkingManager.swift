//
//  MockNetworkingManager.swift
//  SoBored Tests
//
//  Created by Yash Shah on 08/08/2023.
//

import Foundation
@testable import SoBored

final class MockNetworkingManager: NetworkingManaging {
	private let result: Result<ActivityItem, NetworkingError>

	init(result: Result<ActivityItem, NetworkingError>) {
		self.result = result
	}

	func request<T: Decodable>(session: URLSession = .shared, _ url: URL?) async throws -> T {
		switch result {
		case .success(let success): return success as! T
		case .failure(let failure): throw failure
		}
	}
}
