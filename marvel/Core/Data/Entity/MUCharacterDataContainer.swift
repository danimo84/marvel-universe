//
//  MUCharacterDataContainer.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation

struct MUCharacterDataContainer: Codable {
    
    // MARK: -Public contants
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [MUCharacter]?
}
