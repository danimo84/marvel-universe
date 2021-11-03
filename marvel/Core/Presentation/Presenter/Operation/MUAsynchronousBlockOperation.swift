//
//  MUAsynchronousBlockOperation.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// Block based version of the AsynchronousOperation
///
/// Has the same qualities as the AsynchronousOperation, but with an implementation
/// closer to the one of a BlockOperation.
///
/// Once the inner asynchronous operation is finished, call the finish()
/// on the block reference passed. Do not retain the passed block.
///
final class MUAsynchronousBlockOperation : MUAsynchronousOperation {
    
    private var block : (MUAsynchronousBlockOperation) -> ()
    
    init(block : @escaping (MUAsynchronousBlockOperation) -> ()) {
        self.block = block
    }
    
    override func main() {
        
        // If we were executing already
        let wasExecuting = (state == .executing)
        
        // Call our main to ensure we are not cancelled
        super.main()
        
        if !wasExecuting
        {
            block(self)
        }
    }
}
