//
//  MUCharacterDetailComicMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

class MUCharacterDetailComicMapper {
    
    func transform(_ entity:MUComicList) -> MUCharacterDetailComicUseCase {
        
        var object = MUCharacterDetailComicUseCase()
        object.items = [MUCharacterDetailComicSummaryUseCase]()
        if let items = entity.items {
            for item in items {
                let comic = MUCharacterDetailComicSummaryMapper().transform(item)
                object.items?.append(comic)
            }
        }
        
        return object
    }
}
