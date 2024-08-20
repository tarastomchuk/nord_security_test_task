//
//  ServersUseCase.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

class ServersUseCase: ServersUseCaseProtocol {
    
    // MARK: - Injections -
    
    @Injected private var networkService: NetworkServiceProtocol
    @Injected private var tokenStorage: TokenStorageProtocol
    @Injected private var userDefaultsService: UserDefaultsServiceProtocol
    
    // MARK: - Methods -
    
    func getServersList() async throws -> Servers {
        guard let userTokenKey = userDefaultsService.retrieve(forKey: AppKeys.userNameKey) else {
            throw NetworkError.unauthorised
        }
        guard let token = tokenStorage.retrieveToken(forKey: userTokenKey) else {
            throw NetworkError.unauthorised
        }
        var requestConfig = NetworkRequestConfiguration(endpoint: .servers)
        
        requestConfig.headers = [.authorizationKey: .authorizationValue + " \(token)"]
        
        do {
            let serverListResponse = try await networkService.request(
                configuration: requestConfig,
                responseType: Servers.self
            )
            
            return serverListResponse
        } catch {
            print("Fetch servers request failed with error: \(error.localizedDescription)")
            
            throw error
        }
    }
}
