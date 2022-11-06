//
//  NetworkManager+NetworkingError.swift
//  SoBored
//
//  Created by Yash Shah on 06/10/2022.
//

import Foundation

enum NetworkingError: LocalizedError {
    case invalidURL
    case invalidStatusCode(statusCode: Int)
    case failedToDecode
    case custom(Error)

    var errorDescription: String? {
        switch self {
            case .invalidURL: return "The URL is invalid."
            case .invalidStatusCode(let statusCode):
                switch statusCode {
                    case 404: return "No activity found with the specified parameters"
                    default: return "The server returned an invalid status code. 'Status Code: \(statusCode)'"
                }
            case .failedToDecode: return "No activity found with the specified parameters"
            case .custom(let error): return error.localizedDescription
        }
    }
}
