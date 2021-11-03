//
//  MUStoryList.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation

struct MUStoryList: Codable {
    
    // MARK: -Public contants
    
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [MUStorySummary]?
}
