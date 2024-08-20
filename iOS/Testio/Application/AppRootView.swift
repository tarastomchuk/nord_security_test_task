//
//  AppRootView.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI

// AppRootView is a super-lightweight representation of Coordinator
struct AppRootView: View {
    
    // MARK: - Properties -
    
    @StateObject private var viewModel = AppRootViewViewModel()
    
    private let context: AppContextProtocol

    // MARK: - Life Cycle -
    
    init() {
        context = AppContext()
        context.configure()
    }
    
    // MARK: - UI -
    
    var body: some View {
        Group {
            switch viewModel.currentView {
            case .login:
                LoginView(rootViewModel: viewModel)
            case .serversList:
                ServersListView(rootViewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.checkToken()
        }
    }
}

class AppRootViewViewModel: ObservableObject {
    
    // MARK: - Injections -
    
    @Injected private var userDefaultsService: UserDefaultsServiceProtocol
    @Injected private var tokenStorage: TokenStorageProtocol

    // MARK: - Properties -
    
    @Published var currentView: AppRootViews = .login
    
    // MARK: - Logic -

    func checkToken() {
        if let userName = userDefaultsService.retrieve(forKey: AppKeys.userNameKey),
            let _ = tokenStorage.retrieveToken(forKey: userName) {
            print("Details of user \(userName) retrieved successfully")
            currentView = .serversList
        } else {
            print("No user details found")
            currentView = .login
        }
    }
}
