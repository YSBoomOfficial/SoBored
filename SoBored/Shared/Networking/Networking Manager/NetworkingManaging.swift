//
//  NetworkingManaging.swift
//  SoBored
//
//  Created by Yash Shah on 03/11/2022.
//

import Foundation

protocol NetworkingManaging {
    func request<T: Decodable>(session: URLSession, _ url: URL?) async throws -> T
}
