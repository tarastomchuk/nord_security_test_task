//
//  AppContext.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation
import SwiftUI

protocol AppContextProtocol {
    
    func configure()
}

struct AppContext: AppContextProtocol {
    
    func configure() {
        registerDependencies()
    }
}

private extension AppContext {
    
    func registerDependencies() {
        registerServices()
        registerNetworking()
        registerBusinessLogic()
    }

    func registerServices() {
        DIContainerService.shared.register(
            type: UserDefaultsServiceProtocol.self,
            component: UserDefaultsService()
        )
        DIContainerService.shared.register(
            type: TokenStorageProtocol.self,
            component: KeychainService()
        )
    }
    
    func registerNetworking() {
        DIContainerService.shared.register(
            type: NetworkClientManagerProtocol.self,
            component: AlamofireNetworkClient()
        )
        DIContainerService.shared.register(
            type: NetworkServiceProtocol.self,
            component: NetworkService()
        )
    }

    func registerBusinessLogic() {
        DIContainerService.shared.register(
            type: AuthenticationUseCaseProtocol.self,
            component: AuthenticationUseCase()
        )
        DIContainerService.shared.register(
            type: ServersUseCaseProtocol.self,
            component: ServersUseCase()
        )
    }
}
