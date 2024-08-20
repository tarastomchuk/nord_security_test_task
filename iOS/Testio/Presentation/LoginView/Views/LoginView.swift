//
//  LoginView.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties -
    
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var loginTextFieldFocused: Bool
    @FocusState private var passwordTextFieldFocused: Bool
    @State private var showAlert: Bool = false
    @State private var navigateToNextScreen: Bool = false
    
    var rootViewModel: AppRootViewViewModel
    private var edgeInsets: CGFloat = 32
    
    // MARK: - Life Cycle -
    
    init(rootViewModel: AppRootViewViewModel) {
        self.rootViewModel = rootViewModel
    }
    
    // MARK: - UI -
    
    var body: some View {
        VStack {
            Spacer().frame(height: 150)
            
            logoImage
            
            Spacer()
                .frame(height: 40)
            
            VStack(spacing: 16) {
                userNameTextField
                passwordTextField
            }
            .padding(
                .horizontal,
                edgeInsets
            )
            
            Spacer()
                .frame(height: 24)
            
            loginButton
                .padding(
                    .horizontal,
                    edgeInsets
                )
            
            Spacer()
        }
        .background(backgroundImage.ignoresSafeArea())
        .ignoresSafeArea(.keyboard)
        .alert(
            isPresented: $showAlert,
            content: { loginAlert })
        .onChange(of: viewModel.errorMessage) { _ in
            showAlert = viewModel.errorMessage != nil
        }
        .onAppear {
            viewModel.rootViewModel = rootViewModel
        }
    }
}

// MARK: - Private -

private extension LoginView {
    
    var backgroundImage: some View {
        Image(AppImages.backgroundImage)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    var logoImage: some View {
        Image(AppImages.logo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 186, height: 48)
    }
    
    var userNameTextField: some View {
        TextField(
            AppTexts.userNamePlaceholder,
            text: $viewModel.loginDetails.login
        )
        .focused($loginTextFieldFocused)
        .padding(
            EdgeInsets(
                top: 0,
                leading: edgeInsets,
                bottom: 0,
                trailing: edgeInsets)
        )
        .font(.custom(
            AppFonts.SFProDisplayRegular,
            size: 17)
        )
        .frame(height: 40)
        .background(AppColors.textFieldBodyGrey)
        .cornerRadius(10)
        .overlay(
            HStack {
                Image(loginTextFieldFocused ? AppImages.loginTextFieldIconFocused : AppImages.loginTextFieldIcon)
                Spacer()
            }
            .padding(.leading, 9)
        )
    }
    
    var passwordTextField: some View {
        SecureField(
            AppTexts.passwordPlaceholder,
            text: $viewModel.loginDetails.password
        )
        .focused($passwordTextFieldFocused)
        .padding(
            EdgeInsets(
                top: 0,
                leading: edgeInsets,
                bottom: 0,
                trailing: edgeInsets)
        )
        .font(.custom(
            AppFonts.SFProDisplayRegular,
            size: 17)
        )
        .frame(height: 40)
        .background(AppColors.textFieldBodyGrey)
        .cornerRadius(10)
        .overlay(
            HStack {
                Image(passwordTextFieldFocused ? AppImages.passwordTextFieldIconFocused : AppImages.passwordTextFieldIcon)
                Spacer()
            }
            .padding(.leading, 9)
        )
    }
    
    var loginButton: some View {
        Button(action: {
            Task {
                await viewModel.signIn()
            }
        }) {
            if viewModel.isLoading {
                progressView
            } else {
                Text(AppTexts.loginButton)
                    .font(.custom(
                        AppFonts.SFProDisplayRegular,
                        size: 17)
                    )
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            }
        }
        .background(Color.blue)
        .cornerRadius(10)
        .disabled(viewModel.isLoading)
    }
    
    var progressView: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
    }
    
    var loginAlert: Alert {
        Alert(
            title: Text(AppTexts.verificationFailedError),
            message: Text(viewModel.errorMessage ?? AppTexts.unknownError),
            dismissButton: .default(Text(AppTexts.ok), action: {
                viewModel.errorMessage = nil
                showAlert = false
            })
        )
    }
}
