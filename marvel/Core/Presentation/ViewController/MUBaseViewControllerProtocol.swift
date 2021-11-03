//
//  MUBaseViewControllerProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

protocol MUBaseViewControllerProtocol: AnyObject {
    
    func showLoadingMask()
    
    func hideLoadingMask()
    
    func showAlert(title: String, mssg: String)
}
