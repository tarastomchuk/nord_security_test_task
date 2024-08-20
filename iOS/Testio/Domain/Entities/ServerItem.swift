//
//  ServerItem.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

typealias Servers = [ServerItem]

struct ServerItem: Codable {
    
    let name: String
    let distance: Int
}
