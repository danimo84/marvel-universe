//
//  MULoadCharacterDetailUseCase.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

final class MULoadCharacterDetailUseCase {
    
    // MARK: -Public vars
    
    var characterDetailProvider: MUCharacterDetailProviderProtocol?
}

extension MULoadCharacterDetailUseCase: MULoadCharacterDetailUseCaseProtocol {
    
    func execute(characterId: Int, completion: @escaping (_ response: MUCharacterDetailResultUseCase?, _ error: MUAPIException?) -> Void) {
        
        characterDetailProvider?.fetchsCharacterWithId(characterId, { response, error in
            if let characters = response {
                completion(characters, nil)
            } else if let errorReturned = error {
                completion(nil, errorReturned)
            } else {
                completion(nil, MUAPIException.unknownException)
            }
        })
    }
}
