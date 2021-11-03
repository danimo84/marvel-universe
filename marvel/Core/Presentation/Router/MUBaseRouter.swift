//
//  MUBaseRouter.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import UIKit

class MUBaseRouter {
    
    // MARK: - Public variables
    
    var navigationController: UINavigationController?
    
    // MARK: - Public methods
    
    /// Navigate to View controller
    ///
    /// - Parameter viewController - navigation target
    func pushToViewController(_ viewController: UIViewController) {
        
        if let navigationController = navigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    /// Navigate to previous View Controller
    func popViewController() {
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func setNavigationController(_ navController: UINavigationController) {
        
        navigationController = navController
    }
}
