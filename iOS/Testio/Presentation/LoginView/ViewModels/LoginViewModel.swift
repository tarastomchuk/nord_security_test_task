//
//  LoginViewModel.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    
    // MARK: - Injections -
    
    @Injected private var authenticationUseCase: AuthenticationUseCaseProtocol
    
    // MARK: - Published Properties -
    
    @Published var loginDetails: LoginDetails = .init()
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    // MARK: - Properties -
    
    var rootViewModel: AppRootViewViewModel?
    
    // MARK: - Methods -
    
    func signIn() async {
        self.isLoading = true
        let parameters = SignInParameters(userName: loginDetails.login,
                                          password: loginDetails.password)
        
        do {
            _ = try await authenticationUseCase.signIn(with: parameters)
            self.isLoading = false
            self.rootViewModel?.currentView = .serversList
        } catch {
            self.isLoading = false
            self.errorMessage = "\(error.localizedDescription)"
        }
    }
}
