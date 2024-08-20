//
//  ServersListViewModel.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI
import Foundation

@MainActor
class ServersListViewModel: ObservableObject {
    
    // MARK: - Injections -
    
    @Injected private var authenticationUseCase: AuthenticationUseCaseProtocol
    @Injected private var serversUseCase: ServersUseCaseProtocol
    
    // MARK: - Published Properties -
    
    @Published var servers: [ServerDetails] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    // MARK: - Properties -
    
    var rootViewModel: AppRootViewViewModel?
    private var sourceServers: Servers = []
    
    // MARK: - Methods -
    
    func getServersList() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let serverListResponse = try await serversUseCase.getServersList()
            let serverDetailsList = mapServerItemsToDetails(serverListResponse)
            
            self.sourceServers = serverListResponse
            self.servers = serverDetailsList
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    func sortServers(by option: SortingOption) {
        switch option {
        case .byDistance:
            sourceServers.sort { $0.distance < $1.distance }
        case .alphabetical:
            sourceServers.sort { $0.name.lowercased() < $1.name.lowercased() }
        }
        servers = mapServerItemsToDetails(sourceServers)
    }
    
    func logout() {
        authenticationUseCase.removeUserSession()
        rootViewModel?.currentView = .login
    }
}

// MARK: - Private -

private extension ServersListViewModel {
    
    private func mapServerItemsToDetails(_ serverItems: [ServerItem]) -> [ServerDetails] {
        return serverItems.compactMap { serverItem in
            let distanceString = "\(serverItem.distance) \(AppTexts.distanceValue)"
            return ServerDetails(
                name: serverItem.name,
                distance: distanceString
            )
        }
    }
}
