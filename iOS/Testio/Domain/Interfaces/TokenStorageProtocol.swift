//
//  TokenStorage.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

protocol TokenStorageProtocol {
    
    func saveToken(_ token: String, forKey key: String) -> Bool
    func retrieveToken(forKey key: String) -> String?
    func deleteToken(forKey key: String) -> Bool
}
