//
//  ServerDetails.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI
import Foundation

struct ServerDetails: Identifiable {
    
    let id: String = UUID().uuidString
    let name: String
    let distance: String
}
