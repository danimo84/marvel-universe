//
//  MUCharactersPresenterProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import UIKit

protocol MUCharactersPresenterProtocol: MUBasePresenterProtocol {
    
    func bind(view: MUCharactersViewControllerProtocol)
    
    func loadCharacters()
    
    func goToDetail(vc: UIViewController)
    
    func searchCharactersByNameStarsWith(name: String)
    
    func loadNextPageRequest()
    
    func loadPreviousPageRequest()
}
