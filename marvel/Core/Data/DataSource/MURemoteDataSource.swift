//
//  MURemoteDataSource.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// Remote data source
final class MURemoteDataSource {
    
    // MARK: -Public variables
    
    var apiClient: MUApiClientProtocol?
}

// MARK: -MURemoteDataSourceProtocol conformance

extension MURemoteDataSource: MURemoteDataSourceProtocol {
    
    func fetchCharacters(offset: Int, nameStartsWith: String, _ completion: @escaping (MUCharacterDataWrapper?, MUAPIException?) -> Void) {
        apiClient?.fetchCharacters(offset: offset, nameStartsWith: nameStartsWith, { response, error in
            
            if let characters = response {
                completion(characters, nil)
            } else if let errorReturned = error {
                completion(nil, errorReturned)
            } else {
                completion(nil, MUAPIException.unknownException)
            }
        })
    }
    
    func fetchCharacterWithId(_ characterId: Int, _ completion: @escaping (_ response: MUCharacterDataWrapper?, _ error: MUAPIException?) -> Void) {
        apiClient?.fetchCharacterWithId(characterId, { response, error in
            
            if let character = response {
                completion(character, nil)
            } else if let errorReturned = error {
                completion(nil, errorReturned)
            } else {
                completion(nil, MUAPIException.unknownException)
            }
        })
    }
}
