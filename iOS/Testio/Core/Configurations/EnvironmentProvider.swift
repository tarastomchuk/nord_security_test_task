//
//  EnvironmentProvider.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

/// This is simplified version of environments manager, without usage of .xcodeconfig files & project schemas
public enum EnvironmentProvider {
    
    case development
    case production
}

extension EnvironmentProvider {
    
    var baseApiUrl: String {
        switch self {
        case .development:
            return AppConfigs.devBaseApiUrl
        case .production:
            return AppConfigs.prodBaseApiUrl
        }
    }
    var scheme: String {
        switch self {
        case .development:
            return AppConfigs.devScheme
        case .production:
            return AppConfigs.prodScheme
        }
    }
    var apiVersion: String {
        switch self {
        case .development:
            return AppConfigs.devApiVersion
        case .production:
            return AppConfigs.prodApiVersion
        }
    }
    
    // Switch envs here
    /// Simple simulation of different envs
    static var current: EnvironmentProvider {
        #if DEBUG
        return .production
        #else
        return .development
        #endif
    }
}
