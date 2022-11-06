//
//  NetworkingError+Equatable.swift
//  SoBored Tests
//
//  Created by Yash Shah on 06/11/2022.
//

import Foundation
@testable import SoBored

extension NetworkingError: Equatable {
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
            case (.invalidURL, .invalidURL),  (.failedToDecode, .failedToDecode): return true
            case (.invalidStatusCode(let lhsStatusCode), .invalidStatusCode(let rhsStatusCode)):
                return lhsStatusCode == rhsStatusCode
            case (.custom(let lhsError), .custom(let rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            default: return false
        }
    }
}
