//
//  MUAsynchronousOperation.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// Subclass of `Operation` that add support of asynchronous operations.
/// ## How to use:
/// 1. Call `super.main()` when override `main` method, call `super.start()` when override `start` method.
/// 2. When operation is finished or cancelled call `finish()`
open class MUAsynchronousOperation: Operation {
    
    public enum State : String {
        case ready     = "Ready"
        case executing = "Executing"
        case finished  = "Finished"
        fileprivate var keyPath: String { return "is" + self.rawValue }
    }
    
    override open var isAsynchronous : Bool { return true }
    override open var isExecuting    : Bool { return state == .executing }
    override open var isFinished     : Bool { return state == .finished }
    
    public private(set) var state = State.ready {
        willSet(n) {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: n.keyPath)
        }
        didSet(o) {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: o.keyPath)
        }
    }
    
    override open func start() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .ready
            main()
        }
    }
    
    override open func main() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .executing
        }
    }
    
    public func finish() {
        guard state != .finished else { return }
        
        state = .finished
    }
}
