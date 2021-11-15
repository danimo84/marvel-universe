//
//  MUMockApiClient.swift
//  marvelTests
//
//  Created by Daniel Moraleda on 13/11/21.
//

@testable import marvel

class MUMockApiClient: MUApiClientProtocol {
    
    var fetchCharactersIsCalled = false
    var fetchCharacterByIdIsCalled = false
    var isThrowing = false
    
    func fetchCharacters(offset: Int, nameStartsWith: String, _ completion: @escaping (MUCharacterDataWrapper?, MUAPIException?) -> Void) {
        fetchCharactersIsCalled = true
        if isThrowing {
            completion(nil, MUAPIException.unknownException)
        } else {
            completion(MUCharacterDataWrapper(), nil)
        }
    }
    
    func fetchCharacterWithId(_ characterId: Int, _ completion: @escaping (MUCharacterDataWrapper?, MUAPIException?) -> Void) {
        fetchCharacterByIdIsCalled = true
        if isThrowing {
            completion(nil, MUAPIException.unknownException)
        } else {
            completion(MUCharacterDataWrapper(), nil)
        }
    }
}
