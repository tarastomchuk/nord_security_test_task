//
//  SortingOption.swift
//  Testio
//
//  Created by Taras Tomchuk on 14.08.2024.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

enum SortingOption {
    
    case byDistance
    case alphabetical
    
    var description: String {
        switch self {
        case .byDistance:
            return AppTexts.byDistance
        case .alphabetical:
            return AppTexts.alphabetical
        }
    }
}

