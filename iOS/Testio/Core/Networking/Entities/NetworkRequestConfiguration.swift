//
//  NetworkRequestConfiguration.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

public struct NetworkRequestConfiguration {
    
    public var endpoint: AppServiceEndpoint
    public var headers: HTTPHeaders?
    
    public init(endpoint: AppServiceEndpoint,
                headers: HTTPHeaders? = nil) {
        self.endpoint = endpoint
        self.headers = headers
    }
}
