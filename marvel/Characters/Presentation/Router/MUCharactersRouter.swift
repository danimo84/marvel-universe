//
//  MUCharactersRouter.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import UIKit

final class MUCharactersRouter: MUBaseRouter {}

// MARK: -MUCharactersRouterProtocol conformance

extension MUCharactersRouter: MUCharactersRouterProtocol {
    
    func goTo(_ viewController: UIViewController) {
        pushToViewController(viewController)
    }
    
    func setNavController(_ navController: UINavigationController) {
        setNavigationController(navController)
    }
}
