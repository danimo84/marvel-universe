//
//  MUBasePresenter.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// MUBasePresenter
class MUBasePresenter: MUOperationQueueDelegate {
    
    // MARK: Public variables
    
    var queue: MUOperationQueue? = nil
    
    // MARK: Initializers
    
    init() {
        if queue == nil { queue = MUOperationQueue() }
        if let queue = queue { queue.delegate = self }
    }
    
    // MARK: MUOperationQueueDelegate protocol conformance

    /// Send a notification when the operation queue has started
    func operationQueueStarted() {}
    
    /// Send a notification when the operation queue has finished
    func operationQueueFinished() {}
    
    /// Send a notification when the operation needs to be recreated
    ///
    /// - Parameter name: Name of the operation
    func operationNeedsReset(name: String) {}
}
