//
//  MUCharacterResultUseCaseMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 30/10/21.
//

import Foundation

class MUCharacterResultUseCaseMapper {
    
    func transform(_ entity: MUCharacterDataWrapper) -> MUCharacterResultUseCase {
        
        var object = MUCharacterResultUseCase()
        object.offset = entity.data?.offset
        object.limit = entity.data?.limit
        object.total = entity.data?.total
        object.count = entity.data?.count
        object.characters = [MUCharacterUseCase]()
        
        if let results = entity.data?.results {
            for result in results {
                let character = MUCharacterUseCaseMapper().transform(result)
                object.characters?.append(character)
            }
        }
        
        return object
    }
}
