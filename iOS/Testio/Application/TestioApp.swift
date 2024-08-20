//
//  TestioApp.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI

@main
struct TestioApp: App {
    
    init() {
        AppAppearanceConfigurator.configureNavigationBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .preferredColorScheme(.light)
        }
    }
}
