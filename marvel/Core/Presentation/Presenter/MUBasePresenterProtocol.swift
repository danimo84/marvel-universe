//
//  MUBasePresenterProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// Abstraction for MUBasePresenter
protocol MUBasePresenterProtocol {

    /// Tells the presenter that the view has loaded
    func viewDidLoad()
    
    /// Tells the presenter that the view will appear
    func viewWillAppear()
    
    /// Tells the presenter that the view did appear
    func viewDidAppear()
    
    /// Tells the presenter that the view will disappear
    func viewWillDisappear()
    
    /// Tells the presenter that the view did disappear
    func viewDidDisappear()
}

/// Default implementation of optional protocol
extension MUBasePresenterProtocol {
    
    func viewDidLoad() {}
    
    func viewWillAppear() {}
    
    func viewDidAppear() {}
    
    func viewWillDisappear() {}
    
    func viewDidDisappear() {}
}
