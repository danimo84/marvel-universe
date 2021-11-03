//
//  MUCharacterProviderProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 30/10/21.
//

import Foundation

/// Abstraction for characters provider
protocol MUCharacterProviderProtocol {
    
    func fetchCharacters(offset: Int, nameStartsWith: String, _ completion: @escaping (_ response: MUCharacterResultUseCase?, _ error: MUAPIException?) -> Void )
}
