//
//  MUCharacaterDetailResultMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

class MUCharacaterDetailResultMapper {
    
    func transform(_ entity: MUCharacterDataWrapper) -> MUCharacterDetailResultUseCase {
        
        var object = MUCharacterDetailResultUseCase()
        object.characters = [MUCharacterDetailUseCase]()
        
        if let results = entity.data?.results {
            for result in results {
                let character = MUCharacterDetailMapper().transform(result)
                object.characters?.append(character)
            }
        }
        
        return object
    }
}
