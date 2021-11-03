//
//  MUCharacterDetailProvider.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

final class MUCharacterDetailProvider {
    
    // MARK: -Public vars
    
    var remoteDataSource: MURemoteDataSourceProtocol?
}

// MARK: -MUCharacterDetailProviderProtocol conformance

extension MUCharacterDetailProvider: MUCharacterDetailProviderProtocol {
    
    func fetchsCharacterWithId(_ characterId: Int, _ completion: @escaping (_ response: MUCharacterDetailResultUseCase?, _ error: MUAPIException?) -> Void ) {
        
        remoteDataSource?.fetchCharacterWithId(characterId, { response, error in
            if let characters = response {
                let characterResult = MUCharacaterDetailResultMapper().transform(characters)
                completion(characterResult, nil)
            } else if let errorReturned = error {
                completion(nil, errorReturned)
            } else {
                completion(nil, MUAPIException.unknownException)
            }
        })
    }
}
