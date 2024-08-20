//
//  ServersUseCaseProtocol.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

protocol ServersUseCaseProtocol {
    
    func getServersList() async throws -> Servers
}
