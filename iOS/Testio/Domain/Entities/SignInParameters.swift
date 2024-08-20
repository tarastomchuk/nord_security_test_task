//
//  SignInParameters.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

struct SignInParameters: Encodable {
    
    let userName: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case password
    }
}
