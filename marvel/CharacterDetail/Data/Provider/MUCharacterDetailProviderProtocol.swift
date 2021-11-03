//
//  MUCharacterDetailProviderProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation


/// Abstraction for characters provider
protocol MUCharacterDetailProviderProtocol {
    
    func fetchsCharacterWithId(_ characterId: Int, _ completion: @escaping (_ response: MUCharacterDetailResultUseCase?, _ error: MUAPIException?) -> Void )
}
