//
//  MUCharacterDetailMapper.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

class MUCharacterDetailMapper {
    
    func transform(_ entity: MUCharacter) -> MUCharacterDetailUseCase {
        
        let object = MUCharacterDetailUseCase()
        object.id = entity.id
        object.name = entity.name
        object.description = entity.description
        
        if let path = entity.thumbnail?.path, let imgExtension = entity.thumbnail?.imgExtension {
            object.thumbnail = "\(path).\(imgExtension)"
        }
        
        object.comics = MUCharacterDetailComicUseCase()
        if let comics = entity.comics {
            let newComics = MUCharacterDetailComicMapper().transform(comics)
            object.comics = newComics
        }
        
        object.series = MUCharacterDetailSerieUseCase()
        if let series = entity.series {
            let newSeries = MUCharacterDetailSerieMapper().transform(series)
            object.series = newSeries
        }
        
        return object
    }
}
