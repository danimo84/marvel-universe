//
//  MUCharacterDetailStorySummaryMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 5/11/21.
//

import Foundation

class MUCharacterDetailStorySummaryMapper {
    
    func transform(_ entity: MUStorySummary) -> MUCharacterDetailStorySummaryUseCase {
        
        var object = MUCharacterDetailStorySummaryUseCase()
        object.name = entity.name
        object.resourceURI = entity.resourceURI
        
        return object
    }
}
