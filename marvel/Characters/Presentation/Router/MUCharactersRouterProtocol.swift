//
//  MUCharactersRouterProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import UIKit

protocol MUCharactersRouterProtocol {
    
    func goTo(_ viewController: UIViewController)
    
    func setNavController(_ navController: UINavigationController)
}
