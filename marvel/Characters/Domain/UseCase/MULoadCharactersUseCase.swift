//
//  MULoadCharactersUseCase.swift
//  marvel
//
//  Created by Daniel Moraleda on 30/10/21.
//

import Foundation

final class MULoadCharactersUseCase {
    
    // MARK: -Public vars
    
    var characterProvider: MUCharacterProviderProtocol?
}

extension MULoadCharactersUseCase: MULoadCharactersUseCaseProtocol {
    
    func execute(offset: Int, nameStartsWith: String, _ completion: @escaping (_ response: MUCharacterResultUseCase?, _ error: MUAPIException?) -> Void) {
        
        characterProvider?.fetchCharacters(offset: offset, nameStartsWith: nameStartsWith, { response, error in
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
