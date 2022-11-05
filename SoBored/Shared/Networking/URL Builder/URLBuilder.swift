//
//  URLBuilder.swift
//  SoBored
//
//  Created by Yash Shah on 08/10/2022.
//

import Foundation

final class URLBuilder {
	private(set) var requestQueryItems = [String: String]()

	@discardableResult
	func appending(query: QueryType) -> Self {
        guard !query.queryItems.isEmpty else { return self }
		for item in query.queryItems {
			guard requestQueryItems[item.key] == nil else { continue }
			requestQueryItems[item.key] = item.value
		}
		return self
	}

	func build() -> URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "boredapi.com"
		components.path = "/api/activity"
        if !requestQueryItems.isEmpty {
            components.queryItems = requestQueryItems.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
		return components.url
	}

    static var baseURL: URL? {
        Self().build()
    }
}
