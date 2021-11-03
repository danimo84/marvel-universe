//
//  MUOperationQueueDelegate.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// Delegate pattern for MUOperationQueue
protocol MUOperationQueueDelegate {
    
    /// Send a notification when the operation queue has started
    func operationQueueStarted()
    
    /// Send a notification when the operation queue has finished
    func operationQueueFinished()
    
    /// Send a notification when the operation needs to be recreated
    ///
    /// - Parameter name: Name of the operation
    func operationNeedsReset(name: String)
}
