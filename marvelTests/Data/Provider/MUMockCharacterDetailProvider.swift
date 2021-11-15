//
//  MUMockCharacterDetailProvider.swift
//  marvelTests
//
//  Created by Daniel Moraleda on 14/11/21.
//

@testable import marvel

class MUMockCharacterDetailProvider: MUCharacterDetailProviderProtocol {
  
    var fetchCharacterByIdIsCalled = false
    var isThrowing = false

    func fetchsCharacterWithId(_ characterId: Int, _ completion: @escaping (MUCharacterDetailResultUseCase?, MUAPIException?) -> Void) {
        fetchCharacterByIdIsCalled = true
        if isThrowing {
            completion(nil, MUAPIException.unknownException)
        } else {
            completion(MUCharacterDetailResultUseCase(), nil)
        }
    }
}
