//
//  MUCharacterDetailSerieMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

class MUCharacterDetailSerieMapper {
    
    func transform(_ entity: MUSeriesList) -> MUCharacterDetailSerieUseCase {
        
        var object = MUCharacterDetailSerieUseCase()
        object.items = [MUCharacterDetailSerieSummaryUseCase]()
        if let items = entity.items {
            for item in items {
                let serie = MUCharacterDetailSerieSummaryMapper().transform(item)
                object.items?.append(serie)
            }
        }
        
        return object
    }
}
