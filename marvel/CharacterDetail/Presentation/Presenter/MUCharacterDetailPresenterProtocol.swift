//
//  MUCharacterDetailPresenterProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

protocol MUCharacterDetailPresenterProtocol: MUBasePresenterProtocol {
    
    func bind(view: MUCharacterDetailViewControllerProtocol)
    
    func loadCharacter()
}
