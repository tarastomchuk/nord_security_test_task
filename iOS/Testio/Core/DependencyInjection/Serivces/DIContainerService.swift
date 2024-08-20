//
//  DIContainerService.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

final class DIContainerService: DIContainerServiceProtocol {
    
    static let shared = DIContainerService()
    var components: [String: Any] = [:]
    
    private init() {}

    func register<Component>(
        type: Component.Type,
        component: Any
    ) {
        components["\(type)"] = component
    }

    func resolve<Component>(type: Component.Type) -> Component? {
        guard let component = components["\(type)"] as? Component else {
            fatalError("Couldn't find registered component type of \(Component.self)")
        }
        return component
    }
}
