//
//  MUCharacterDetailComicSummaryMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

class MUCharacterDetailComicSummaryMapper {
    
    func transform(_ entity: MUComicSummary) -> MUCharacterDetailComicSummaryUseCase {
        
        var object = MUCharacterDetailComicSummaryUseCase()
        object.name = entity.name
        object.resourceURI = entity.resourceURI
        
        return object
    }
}
