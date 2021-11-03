//
//  MUCharacter.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation

struct MUCharacter: Codable {
    
    // MARK: -Public contants
    
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let resourceURI: String?
    let urls: [MUUrl]?
    let thumbnail: MUImage?
    let comics: MUComicList?
    let stories: MUStoryList?
    let events: MUEventList?
    let series: MUSeriesList?
}
