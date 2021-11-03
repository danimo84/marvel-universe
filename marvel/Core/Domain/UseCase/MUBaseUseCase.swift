//
//  MUBaseUseCase.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// Base UseCase
class MUBaseUseCase {
    
    // MARK: Public variables
    
    var networkProvider: MUNetworkProviderProtocol?
    
    // MARK: Public methods
    
    /// Check Internet connection
    ///
    /// - Throws: LFAPIException.connectivityException
    func checkInternetConnection() throws {
        guard let hasInternetConnection = networkProvider?.hasInternetConnection() else {
            throw MUAPIException.connectivityException
        }
        if !hasInternetConnection { throw MUAPIException.connectivityException }
    }
}
