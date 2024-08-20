//
//  HTTPUrlResponse+Extension.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    var type: HTTPResponseType {
        switch statusCode {
        case 200..<300:
            return .success

        case 400..<500:
            return .clientError

        case 500..<600:
            return .serverError

        default:
            return .undefined
        }
    }

    enum HTTPResponseType {
        
        case success
        case clientError
        case serverError
        case undefined
    }
}
