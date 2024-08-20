//
//  UserDefaultsServiceProtocol.swift
//  Testio
//
//  Created by Taras Tomchuk on 19.08.2024.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    
    func save(_ value: String, forKey key: String)
    func retrieve(forKey key: String) -> String?
    func remove(forKey key: String)
}
