//
//  MULoadCharacterDetailUseCaseProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

protocol MULoadCharacterDetailUseCaseProtocol {
    
    func execute(characterId: Int, completion: @escaping (_ response: MUCharacterDetailResultUseCase?, _ error: MUAPIException?) -> Void )
}
