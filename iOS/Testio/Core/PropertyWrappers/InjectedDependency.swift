//
//  InjectedDependency.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

@propertyWrapper
struct Injected<Dependency> {
    
    private var dependency: Dependency

    init() {
        self.dependency = DIContainerService.shared.resolve(type: Dependency.self)!
    }

    var wrappedValue: Dependency {
        get { dependency }
        set { dependency = newValue }
    }
}
