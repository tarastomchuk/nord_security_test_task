//
//  AuthenticationUseCaseProtocol.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

protocol AuthenticationUseCaseProtocol {
    
    func signIn(with parameters: SignInParameters) async throws -> SignInResponse
    func removeUserSession()
}
