//
//  MUCharactersViewControllerProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation
import UIKit

protocol MUCharactersViewControllerProtocol: MUBaseViewControllerProtocol {
    
    func setupView()
    
    func showLoading()
    
    func hideLoading()
    
    func showError(exception: MUAPIException?)
     
    func displayCharacters(_ charactersList: [MUCharacterUseCase], offset: Int, total: Int, limit: Int)
    
    func getNavigation() -> UINavigationController?
}
