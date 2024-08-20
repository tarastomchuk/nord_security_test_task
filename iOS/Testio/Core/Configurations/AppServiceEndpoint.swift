//
//  AppServiceEndpoint.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

public enum AppServiceEndpoint: String {
    
    case login = "tokens"
    case servers = "servers"
}

// This is lightweight representation of url builder with default values for each endpoint
extension AppServiceEndpoint {
    
    var url: URLComponents {
        var components = BaseUrl.components
        
        components.path += "/\(self.rawValue)"
        
        return components
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .servers:
            return .get
        }
    }
    var encoding: ParameterEncoding {
        switch self {
        case .login, .servers:
            return .json
        }
    }
}
