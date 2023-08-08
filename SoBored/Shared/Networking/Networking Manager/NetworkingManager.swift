//
//  NetworkingManager.swift
//  SoBored
//
//  Created by Yash Shah on 06/10/2022.
//

import Foundation

final class NetworkingManager: NetworkingManaging {
	static let shared = NetworkingManager()

	private init() {}

	func request<T: Decodable>(session: URLSession = .shared, _ url: URL?) async throws -> T {
		guard let url else { throw NetworkingError.invalidURL }

		let (data, response) = try await session.data(from: url)

		guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
			let statusCode = (response as! HTTPURLResponse).statusCode
			throw NetworkingError.invalidStatusCode(statusCode: statusCode)
		}

		do {
			return try JSONDecoder().decode(T.self, from: data)
		} catch {
			throw NetworkingError.failedToDecode
		}
	}
}
