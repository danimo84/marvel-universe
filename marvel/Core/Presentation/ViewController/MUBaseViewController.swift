//
//  MUBaseViewController.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import UIKit

class MUBaseViewController: UIViewController {
        
    // MARK: -Private vars
    
    private var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndicator()
    }
    
    private func setupIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: self.view.bounds)
        activityIndicator?.style = .large
        if activityIndicator != nil {
            view.addSubview(activityIndicator!)
        }
    }
}

extension MUBaseViewController: MUBaseViewControllerProtocol {
    
    func showLoadingMask() {
        activityIndicator?.startAnimating()
        activityIndicator?.isHidden = false
    }
    
    func hideLoadingMask() {
        activityIndicator?.stopAnimating()
        activityIndicator?.isHidden = true
    }
    
    func showAlert(title: String, mssg: String) {
        let alert = UIAlertController(title: title, message: mssg, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: nil))
        present(alert, animated: true)
    }
}
