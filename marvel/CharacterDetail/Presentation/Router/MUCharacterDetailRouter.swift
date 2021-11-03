//
//  MUCharacterDetailRouter.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import UIKit

final class MUCharacterDetailRouter: MUBaseRouter {}

extension MUCharacterDetailRouter: MUCharacterDetailRouterProtocol {
    
    func setNavController(_ navController: UINavigationController) {
        setNavigationController(navController)
    }
}
