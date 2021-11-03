//
//  MUImage.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation

struct MUImage: Codable {
    
    // MARK: -Public contants
    
    let path: String?
    let imgExtension: String?
    
    // MARK: -Custom CodingKey
    
    enum CodingKeys: String, CodingKey {
        case path
        case imgExtension = "extension"
    }
}
