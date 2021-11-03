//
//  MURemoteDataSourceProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// Abstraction for remote data source
protocol MURemoteDataSourceProtocol {
    
    func fetchCharacters(offset: Int, nameStartsWith: String, _ completion: @escaping (_ response: MUCharacterDataWrapper?, _ error: MUAPIException?) -> Void)
    
    func fetchCharacterWithId(_ characterId: Int, _ completion: @escaping (_ response: MUCharacterDataWrapper?, _ error: MUAPIException?) -> Void)
}
