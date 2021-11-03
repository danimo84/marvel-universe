//
//  MUOperationQueue.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// Responsible for executing async operations
final class MUOperationQueue: OperationQueue {
    
    // MARK: Private variables
    
    private var observation: NSKeyValueObservation?
    private var customOperations: [Operation]?
    
    // MARK: Public variables
    
    var delegate: MUOperationQueueDelegate?
    
    // MARK: Overriden methods
    
    override init() {
        super.init()
        qualityOfService = .background
        addObserverWhenFinished()
    }
    
    // MARK: Deinitializers
    
    deinit {
        self.observation = nil
    }
    
    // MARK: Public methods
    
    /// Add operations to the queue
    ///
    /// - Parameter operations: [Operation]
    func addOperations(operations: [Operation]) {
        
        let result = checkValidOperations(operations: operations)
        if result.validOperations {
            if let operations = result.operations {
                customOperations = operations
            }
        } else {
            customOperations = nil
            if let delegate = delegate { delegate.operationQueueFinished() }
        }
    }
    
    /// Start operations
    func start() {
        
        if let operations = customOperations {
            if let delegate = delegate { delegate.operationQueueStarted() }
            addOperations(operations, waitUntilFinished: false)
        } else {
            if let delegate = delegate { delegate.operationQueueFinished() }
        }
    }
    
    /// Cancel operations
    func cancelOperations() {
        
        cancelAllOperations()
    }
    
    // MARK: Private methods
    
    /// Check valid operations
    ///
    /// - Parameter operations: Operations array
    /// - Returns: (operations: [Operation]?, validOperations: Bool)
    private func checkValidOperations(operations: [Operation]) ->
        (operations: [Operation]?, validOperations: Bool) {
            
        var validOperations = operations
        for operation in operations {
            if operation.isFinished || operation.isExecuting || customOperations?.contains(operation) == true {
                if let customIndex = validOperations.firstIndex(of: operation) {
                    validOperations.remove(at: customIndex)
                }
            }
        }
        if !validOperations.isEmpty {
            return (operations: validOperations, validOperations: true)
        }
        return (operations: nil, validOperations: false)
    }
    
    /// Add observer when queue finished
    private func addObserverWhenFinished() {
        
        observation = self.observe(\.operationCount, options: [.new]) { [unowned self] (queue, change) in
            if change.newValue! == 0 {
                if let delegate = self.delegate {
                    delegate.operationQueueFinished()
                }
                self.reset()
            }
        }
    }
    
    /// Reset operations (from isFinished = true to isFinished = false)
    private func reset() {
        
        guard let operations = customOperations else { return }
        guard let delegate = delegate else { return }
        for operation in operations {
            if operation.isFinished {
                if let operationName = operation.name {
                    delegate.operationNeedsReset(name: operationName)
                }
            }
        }
    }
}
