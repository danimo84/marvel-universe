//
//  MUCharacterDetailSerieSummaryMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

class MUCharacterDetailSerieSummaryMapper {
    
    func transform(_ entity: MUSeriesSummary) -> MUCharacterDetailSerieSummaryUseCase {
        
        var object = MUCharacterDetailSerieSummaryUseCase()
        object.name = entity.name
        object.resourceURI = entity.resourceURI
        
        return object
    }
}
