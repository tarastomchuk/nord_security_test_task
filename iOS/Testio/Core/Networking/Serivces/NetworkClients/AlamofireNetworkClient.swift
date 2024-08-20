//
//  AlamofireNetworkClient.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Alamofire
import Foundation

final class AlamofireNetworkClient: NetworkClientManagerProtocol {
    
    // MARK: - Request -
    
    func request<Output: Decodable>(
        configuration: NetworkRequestConfiguration,
        parameters: [String: Any]?,
        responseType: Output.Type,
        decoder: JSONDecoder
    ) async throws -> Output {
        do {
            let response = try await AF.request(
                configuration.endpoint.url,
                method: adaptHTTPMethod(from: configuration.endpoint.httpMethod),
                parameters: parameters,
                encoding: adaptEncoding(from: configuration.endpoint.encoding),
                headers: adaptHeaders(from: configuration.headers)
            )
                .validate(statusCode: 200..<300)
                .serializingDecodable(responseType, 
                                      decoder: decoder)
                .value
            return response
            
        } catch let error as AFError {
            throw handleAlamofireError(error)
            
        } catch _ as DecodingError {
            throw NetworkError.decodingFailed
            
        } catch {
            throw NetworkError.requestFailed(error)
            
        }
    }
}

// MARK: - Private -

private extension AlamofireNetworkClient {
    
    private func adaptHTTPMethod(from source: Testio.HTTPMethod) -> Alamofire.HTTPMethod {
        switch source {
        case .get:
            return .get
        case .post:
            return .post
        default:
            return .get
        }
    }
    
    private func adaptEncoding(from source: Testio.ParameterEncoding) -> Alamofire.ParameterEncoding {
        switch source {
        case .url:
            return URLEncoding.default
        case .json:
            return JSONEncoding.default
        }
    }
    
    private func adaptHeaders(from source: Testio.HTTPHeaders?) -> Alamofire.HTTPHeaders {
        var headers: Alamofire.HTTPHeaders = [:]
        guard let source = source else {
            return [:]
        }
        
        for (key, value) in source {
            headers.add(name: key, value: value)
        }
        
        return headers
    }
    
    private func handleAlamofireError(_ error: AFError) -> NetworkError {
        switch error {
        case .invalidURL(_):
            return .invalidURL
            
        case .responseSerializationFailed(_):
            return .decodingFailed
            
        case .sessionTaskFailed(let underlyingError):
            return .requestFailed(underlyingError)
            
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(let code):
                return .unexpectedStatusCode(code)
                
            default:
                return .responseValidationFailed
            }
            
        default:
            return .unexpected(message: "Unexpected error: \(error.localizedDescription)")
            
        }
    }
}
