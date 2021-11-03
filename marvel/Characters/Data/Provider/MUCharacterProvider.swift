//
//  MUCharacterProvider.swift
//  marvel
//
//  Created by Daniel Moraleda on 30/10/21.
//

import Foundation

/// MUCharacterProvider
final class MUCharacterProvider {
    
    // MARK: -Public vars
    
    var remoteDataSource: MURemoteDataSourceProtocol?
}

// MARK: -MUCharacterProviderProtocol conformance

extension MUCharacterProvider: MUCharacterProviderProtocol {
    
    /// Fetch Characters
    ///
    /// -Parameters offset: Int, nameStartsWith: String
    func fetchCharacters(offset: Int, nameStartsWith: String, _ completion: @escaping (MUCharacterResultUseCase?, MUAPIException?) -> Void) {
        
        remoteDataSource?.fetchCharacters(offset: offset, nameStartsWith: nameStartsWith, { response, error in
            if let characters = response {
                let characterResult = MUCharacterResultUseCaseMapper().transform(characters)
                completion(characterResult, nil)
            } else if let errorReturned = error {
                completion(nil, errorReturned)
            } else {
                completion(nil, MUAPIException.unknownException)
            }
        })
    }
}
