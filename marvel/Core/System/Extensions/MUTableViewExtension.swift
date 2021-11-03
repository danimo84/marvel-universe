//
//  MUTableViewExtension.swift
//  marvel
//
//  Created by Daniel Moraleda on 2/11/21.
//

import Foundation
import UIKit

extension UITableView {
    
    func reloadData(completion: @escaping () -> ()) {
        
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
