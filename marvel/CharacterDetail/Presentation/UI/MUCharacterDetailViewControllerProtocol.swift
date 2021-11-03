//
//  MUCharacterDetailViewControllerProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation
import UIKit

protocol MUCharacterDetailViewControllerProtocol: MUBaseViewControllerProtocol {
    
    func setupView()
    
    func showLoading()
    
    func hideLoading()
    
    func showError(exception: MUAPIException?)
    
    func displayCharacter(_ characters: [MUCharacterDetailUseCase])
    
    func getCharacterId() -> Int
    
    func getNavigation() -> UINavigationController?
}
