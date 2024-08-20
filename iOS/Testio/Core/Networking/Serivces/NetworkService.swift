//
//  NetworkService.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Injections -
    
    @Injected private var networkRequestService: NetworkClientManagerProtocol
    
    // MARK: - Properties -
    
    private lazy var encoder = JSONEncoder()
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    // MARK: - Request -
    
    func request<Input: Encodable, Output: Decodable>(
        configuration: NetworkRequestConfiguration,
        input: Input,
        responseType: Output.Type
    ) async throws -> Output {
        let parameters: [String: Any]? = try {
            let dictionary = try encodeToDictionary(input)
            return dictionary.isEmpty ? nil : dictionary
        }()
        
        print("Request URL: \(configuration.endpoint.url)")
        print("HTTP Method: \(configuration.endpoint.httpMethod)")
        print("Headers: \(String(describing: configuration.headers))")
        print("Parameters: \(String(describing: parameters))")
        print("Encoding: \(configuration.endpoint.encoding)")
        
        do {
            let dataResponse = try await networkRequestService.request(
                configuration: configuration,
                parameters: parameters,
                responseType: responseType,
                decoder: decoder
            )
            print("Response: \(dataResponse)")
            
            return dataResponse
        } catch {
            print("Request failed with error: \(error)")
            
            throw error
        }
    }
}

// MARK: - Private -

private extension NetworkService {
    
    func encodeToDictionary<T: Encodable>(_ value: T) throws -> [String: Any] {
        let data = try encoder.encode(value)
        let dictionary = try JSONSerialization.jsonObject(
            with: data,
            options: []
        ) as? [String: Any]
        
        return dictionary ?? [:]
    }
}
