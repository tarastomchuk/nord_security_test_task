//
//  AuthenticationUseCase.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

class AuthenticationUseCase: AuthenticationUseCaseProtocol {
    
    // MARK: - Injections -
    
    @Injected private var networkService: NetworkServiceProtocol
    @Injected private var tokenStorage: TokenStorageProtocol
    @Injected private var userDefaultsService: UserDefaultsServiceProtocol
    
    // MARK: - Methods -
    
    func signIn(with parameters: SignInParameters) async throws -> SignInResponse {
        let requestConfig = NetworkRequestConfiguration(endpoint: .login)
        
        do {
            let signInResponse = try await networkService.request(
                configuration: requestConfig,
                input: parameters,
                responseType: SignInResponse.self
            )
            print("Sign-in successful, received token: \(signInResponse.token)")
            _ = tokenStorage.saveToken(
                signInResponse.token,
                forKey: parameters.userName
            )
            userDefaultsService.save(
                parameters.userName,
                forKey: AppKeys.userNameKey
            )
            
            return signInResponse
        } catch {
            print("Sign-in request failed with error: \(error.localizedDescription)")
            
            throw error
        }
    }
    
    func removeUserSession() {
        let userTokenKey = userDefaultsService.retrieve(forKey: AppKeys.userNameKey)
        _ = tokenStorage.deleteToken(forKey: userTokenKey ?? "")
    }
}


