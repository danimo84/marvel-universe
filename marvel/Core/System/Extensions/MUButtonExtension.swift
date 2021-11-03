//
//  MUButtonExtension.swift
//  marvel
//
//  Created by Daniel Moraleda on 2/11/21.
//

import UIKit

extension UIButton {
    
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    func setupPaginationButtonWithTitle(_ title: String, bgColor: UIColor, titleColor: UIColor) {
        
        setTitle(title, for: .normal)
        backgroundColor = .white
        setTitleColor(.red, for: .normal)
    }
}
