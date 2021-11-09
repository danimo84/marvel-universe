//
//  MUCharacterDetailEventSummaryMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 5/11/21.
//

import Foundation

class MUCharacterDetailEventSummaryMapper {
    
    func transform(_ entity: MUEventSummary) -> MUCharacterDetailEventSummaryUseCase {
        
        var object = MUCharacterDetailEventSummaryUseCase()
        object.name = entity.name
        object.resourceURI = entity.resourceURI
        
        return object
    }
}
