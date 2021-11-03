//
//  MULoadCharactersUseCaseProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 30/10/21.
//

import Foundation

protocol MULoadCharactersUseCaseProtocol {
    
    func execute(offset: Int, nameStartsWith: String, _ completion: @escaping (_ response: MUCharacterResultUseCase?, _ error: MUAPIException?) -> Void )
}
