//
//  MUAPIException.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation

/// APIException
enum MUAPIException: Error {
    case connectivityException
    case forbiddenException
    case characterNotFoundException
    case unknownException
}

enum MUAPIExceptionMessage: String {
    case unknownException = "Are you config your Private and Public key on info.plist?"
}
