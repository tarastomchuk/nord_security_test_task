//
//  UserDefaultsService.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

class UserDefaultsService: UserDefaultsServiceProtocol {
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Saving Data -
    
    func save(_ value: String, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    // MARK: - Retrieving Data -
    
    func retrieve(forKey key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    // MARK: - Removing Data -
    
    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
