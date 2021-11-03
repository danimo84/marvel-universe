//
//  MUCharacterResultUseCase.swift
//  marvel
//
//  Created by Daniel Moraleda on 30/10/21.
//

import Foundation

struct MUCharacterResultUseCase {
    
    // MARK: -Public vars
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var characters: [MUCharacterUseCase]?
}
