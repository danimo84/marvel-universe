//
//  MUCharacterDataWrapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation

struct MUCharacterDataWrapper: Codable {
    
    // MARK: -Public contants
    
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionHTML: String?
    let etag: String?
    let data: MUCharacterDataContainer?
}
