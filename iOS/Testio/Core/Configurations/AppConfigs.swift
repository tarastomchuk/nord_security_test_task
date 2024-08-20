//
//  AppConfigs.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

/// Goal of this file is to substitute .xcodeconfig files, but simulate similar behaviour

struct AppConfigs {
    
    static var devBaseApiUrl: String {
        return "google.com"
    }
    static var prodBaseApiUrl: String {
        return "playground.tesonet.lt"
    }
    
    static var devScheme: String {
        return "http"
    }
    static var prodScheme: String {
        return "https"
    }
    
    static var devApiVersion: String {
        return "v2"
    }
    static var prodApiVersion: String {
        return "v1"
    }
}
