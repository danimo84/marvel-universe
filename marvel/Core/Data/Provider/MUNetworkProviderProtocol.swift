//
//  MUNetworkProviderProtocol.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

protocol MUNetworkProviderProtocol {
    
    /// Check if there is a valid Internet connection
    ///
    /// - Returns: true if device has Internet connection, false otherwise
    func hasInternetConnection() -> Bool
}
