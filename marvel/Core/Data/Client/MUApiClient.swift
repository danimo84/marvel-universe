//
//  MUApiClient.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation

final class MUApiClient: MUBaseClient {
    
    // MARK: -Private constants
    
    let host: MUAPIHost = .marvelUniverseApi
}

// MARK: -MUApiClientProtocol conformance

extension MUApiClient: MUApiClientProtocol {
    
    func fetchCharacters(offset: Int, nameStartsWith: String, _ completion: @escaping (_ response: MUCharacterDataWrapper?, _ error: MUAPIException?) -> Void) {
        
        request(MUEndpoint.characters(
            host: host,
            version: MUAPIVersion.v1,
            offset: offset,
            nameStartsWith: nameStartsWith)
        ) { response, error in
            if let data = response?.data {
                do {
                    let characterDataWrapper = try JSONDecoder().decode(MUCharacterDataWrapper.self, from: data)
                    completion(characterDataWrapper, nil)
                } catch let exception {
                    completion(nil, exception as? MUAPIException)
                }
            } else if let errorReturned = error {
                completion(nil, errorReturned)
            } else {
                completion(nil, MUAPIException.unknownException)
            }
        }
    }
    
    func fetchCharacterWithId(_ characterId: Int, _ completion: @escaping (MUCharacterDataWrapper?, MUAPIException?) -> Void) {
        
        request(MUEndpoint.character(
            host: host,
            version: MUAPIVersion.v1,
            characterId: characterId)
        ) { response, error in
            if let data = response?.data {
                do {
                    let characterDataWrapper = try JSONDecoder().decode(MUCharacterDataWrapper.self, from: data)
                    completion(characterDataWrapper, nil)
                } catch let exception {
                    completion(nil, exception as? MUAPIException)
                }
            } else if let errorReturned = error {
                completion(nil, errorReturned)
            } else {
                completion(nil, MUAPIException.unknownException)
            }
        }
    }
}
