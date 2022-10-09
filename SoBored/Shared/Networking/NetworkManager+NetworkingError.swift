//
//  NetworkManager+NetworkingError.swift
//  SoBored
//
//  Created by Yash Shah on 06/10/2022.
//

import Foundation

extension NetworkingManager {
	enum NetworkingError: LocalizedError {
		case invalidURL
		case invalidStatusCode(statusCode: Int)
		case failedToDecode(error: Error)
		case custom(Error)

		var errorDescription: String? {
			switch self {
				case .invalidURL: return "The URL is invalid."
				case .invalidStatusCode(let statusCode):
					switch statusCode {
						case 404: return "404 Not Found"
						default: return "The status code was invalid. \(statusCode)"
					}
				case .failedToDecode(let error): return "Could not decode response. \(error.localizedDescription)"
				case .custom(let error): return "Something went wrong. \(error.localizedDescription)."
			}
		}
	}
}
