//
//  MockURLSessionProtocol.swift
//  SoBored Tests
//
//  Created by Yash Shah on 04/11/2022.
//

import Foundation

final class MockURLSessionProtocol: URLProtocol {
    static var loadingHandler: (()-> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let handler = Self.loadingHandler else {
            fatalError("Loading Handler not set")
        }

        let (response, data) = handler()
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
