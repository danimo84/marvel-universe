//
//  MUMockCharacterProvider.swift
//  marvelTests
//
//  Created by Daniel Moraleda on 14/11/21.
//

@testable import marvel

class MUMockCharacterProvider: MUCharacterProviderProtocol {
    
    var fetchCharactersIsCalled = false
    var isThrowing = false
    
    func fetchCharacters(offset: Int, nameStartsWith: String, _ completion: @escaping (MUCharacterResultUseCase?, MUAPIException?) -> Void) {
        fetchCharactersIsCalled = true
        if isThrowing {
            completion(nil, MUAPIException.unknownException)
        } else {
            completion(MUCharacterResultUseCase(), nil)
        }
    }
}
