//
//  NetworkError.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    case unauthorised
    case invalidURL
    case requestFailed(Error)
    case decodingFailed
    case unexpectedStatusCode(Int)
    case noData
    case unexpected(message: String)
    case responseValidationFailed
    case custom(message: String)
    
    var description: String {
        switch self {
        case .unauthorised:
            return "Your session has expired, please log in again"
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let error):
            return "Client error \n\(error)"
        case .decodingFailed:
            return "Error decoding data"
        case .unexpectedStatusCode(let error):
            return "Server error \n\(error)"
        case .noData:
            return "No data received"
        case .unexpected(message: let message):
            return "Something went wrong\nTry again. Details: \(message)"
        case .responseValidationFailed:
            return "Error validating data"
        case .custom(message: let message):
            return message
        }
    }
}
