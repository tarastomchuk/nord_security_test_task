//
//  NetworkClientManagerProtocol.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

protocol NetworkClientManagerProtocol {
    
    func request<Output: Decodable>(
        configuration: NetworkRequestConfiguration,
        parameters: [String: Any]?,
        responseType: Output.Type,
        decoder: JSONDecoder
    ) async throws -> Output
}
