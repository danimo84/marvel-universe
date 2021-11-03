//
//  MUCharacterUseCaseMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 30/10/21.
//

import Foundation

class MUCharacterUseCaseMapper {

    func transform(_ entity: MUCharacter) -> MUCharacterUseCase {
        
        let object = MUCharacterUseCase()
        object.id = entity.id
        object.name = entity.name
        object.description = entity.description
        
        if let path = entity.thumbnail?.path, let imgExtension = entity.thumbnail?.imgExtension {
            object.thumbnail = "\(path).\(imgExtension)"
        }
        
        return object
    }

}
