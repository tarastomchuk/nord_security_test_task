//
//  DIContainer.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//

import Foundation

@propertyWrapper struct Injected<Dependency> {
    
    let wrappedValue: Dependency
    
    init() {
        self.wrappedValue = DIContainerService.shared.resolve(type: Dependency.self)
    }
}

protocol DIContainerProtocol {
    
    func register<Component>(type: Component.Type, component: Any)
    func resolve<Component>(type: Component.Type) -> Component
}

final class DIContainerService: DIContainerProtocol {
    
    static let shared = DIContainerService()
    var components: [String: Any] = [:]
    
    private init() {}

    func register<Component>(type: Component.Type, component: Any) {
        components["\(type)"] = component
    }

    func resolve<Component>(type: Component.Type) -> Component {
        guard let component = components["\(type)"] as? Component else {
            fatalError("Couldn't find registered component type of \(Component.self)")
        }
        return component
    }
}
