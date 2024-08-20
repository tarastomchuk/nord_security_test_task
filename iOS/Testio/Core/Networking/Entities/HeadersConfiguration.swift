//
//  HeadersConfiguration.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public struct HeadersConfiguration {
    
    public static var defaultHeaders: HTTPHeaders {
        let headers: HTTPHeaders = [
            .headerAcceptKey: .headerAcceptValue,
            .headerConnectionKey: .headerConnectionValue,
            .headerContentTypeKey: .headerContentTypeJsonValue
        ]
        
        return headers
    }
}
