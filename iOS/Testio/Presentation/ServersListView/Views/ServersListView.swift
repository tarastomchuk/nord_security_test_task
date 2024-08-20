//
//  ServersListView.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI

struct ServersListView: View {
    
    // MARK: - Properties -
    
    @StateObject private var viewModel = ServersListViewModel()
    @State private var showingSortOptions = false
    
    var rootViewModel: AppRootViewViewModel
    
    // MARK: - Life Cycle -
    
    init(rootViewModel: AppRootViewViewModel) {
        self.rootViewModel = rootViewModel
    }
    
    // MARK: - UI -
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    loadingView
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(errorMessage)
                } else {
                    VStack {
                        headerTitles
                        serverList
                    }
                }
            }
            .navigationBarTitle(
                AppTexts.appName,
                displayMode: .inline
            )
            .navigationBarItems(
                leading: filterButton,
                trailing: logoutButton
            )
            .actionSheet(isPresented: $showingSortOptions) {
                sortActionSheet
            }
        }
        .onAppear {
            viewModel.rootViewModel = rootViewModel
            Task {
                await viewModel.getServersList()
            }
        }
    }
}

// MARK: - Private -

private extension ServersListView {
    
    var loadingView: some View {
        ProgressView(AppTexts.loadingList)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .font(.custom(
                AppFonts.SFProDisplayRegular,
                size: 17)
            )
    }
    
    func errorView(_ message: String) -> some View {
        Text(message)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    var headerTitles: some View {
        HStack {
            Text(AppTexts.server.uppercased())
                .font(.custom(
                    AppFonts.SFProDisplayRegular,
                    size: 12)
                )
                .foregroundColor(.gray)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            Text(AppTexts.distance.uppercased())
                .font(.custom(
                    AppFonts.SFProDisplayRegular,
                    size: 12)
                )
                .foregroundColor(.gray)
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
        }
        .padding(.horizontal)
        .padding(.top, 24)
        .padding(.bottom, 8)
        .background(AppColors.listBackgroundGrey)
    }
    
    var filterButton: some View {
        Button(action: {
            showingSortOptions = true
        }) {
            HStack {
                Image(AppImages.filter)
                Text(AppTexts.filterButton)
                    .font(.custom(
                        AppFonts.SFProDisplayRegular,
                        size: 17)
                    )
            }
        }
        
    }
    
    var logoutButton: some View {
        Button(action: {
            viewModel.logout()
        }) {
            HStack {
                Text(AppTexts.logoutButton)
                    .font(.custom(
                        AppFonts.SFProDisplayRegular,
                        size: 17)
                    )
                Image(AppImages.logout)
            }
        }
    }
    
    var serverList: some View {
        List(viewModel.servers) { server in
            HStack {
                serverListItemText(
                    server.name,
                    alignment: .leading
                )
                serverListItemText(
                    server.distance,
                    alignment: .trailing
                )
            }
        }
        .listStyle(PlainListStyle())
    }
    
    func serverListItemText(
        _ text: String,
        alignment: Alignment
    ) -> some View {
        Text(text)
            .font(.custom(
                AppFonts.SFProDisplayRegular,
                size: 17)
            )
            .frame(
                maxWidth: .infinity,
                alignment: alignment
            )
    }
    
    var sortActionSheet: ActionSheet {
        ActionSheet(
            title: Text(""),
            buttons: [
                .default(
                    Text(SortingOption.byDistance.description)
                        .font(.custom(
                            AppFonts.SFProDisplayRegular,
                            size: 17)
                        )
                ) {
                    viewModel.sortServers(by: .byDistance)
                },
                .default(
                    Text(SortingOption.alphabetical.description)
                        .font(.custom(
                            AppFonts.SFProDisplayRegular,
                            size: 17)
                        )) {
                    viewModel.sortServers(by: .alphabetical)
                },
                .cancel()
            ]
        )
    }
}
