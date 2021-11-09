//
//  MUCharacterDetailStoryMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 5/11/21.
//

import Foundation

class MUCharacterDetailStoryMapper {
    
    func transform(_ entity: MUStoryList) -> MUCharacterDetailStoryUseCase {
        
        var object = MUCharacterDetailStoryUseCase()
        object.items = [MUCharacterDetailStorySummaryUseCase]()
        if let items = entity.items {
            for item in items {
                let story = MUCharacterDetailStorySummaryMapper().transform(item)
                object.items?.append(story)
            }
        }
        
        return object
    }
    
}
