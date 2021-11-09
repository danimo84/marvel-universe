//
//  MUCharacterDetailEventMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 5/11/21.
//

import Foundation

class MUCharacterDetailEventMapper {
    
    func transform(_ entity: MUEventList) -> MUCharacterDetailEventUseCase {
        
        var object = MUCharacterDetailEventUseCase()
        object.items = [MUCharacterDetailEventSummaryUseCase]()
        if let items = entity.items {
            for item in items {
                let event = MUCharacterDetailEventSummaryMapper().transform(item)
                object.items?.append(event)
            }
        }
        
        return object
    }
}
