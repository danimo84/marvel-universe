//
//  MUEndpoint.swift
//  marvel
//
//  Created by Daniel Moraleda on 28/10/21.
//

import Foundation
import Alamofire

enum MUEndpoint {
    
    // MARK: -Enpoints
    
    case characters(host: MUAPIHost, version: MUAPIVersion, offset: Int, nameStartsWith: String)
    case character(host: MUAPIHost, version: MUAPIVersion, characterId: Int)
    
    // MARK: -Public vars
    
    var host: String {
        switch self {
        case .characters(host: let host, version: _, offset: _, nameStartsWith: _),
                .character(host: let host, version: _, characterId: _):
            return getURLWithHost(host)
        }
    }
    
    var version: String {
        switch self {
        case .characters(host: _, version: let version, offset: _, nameStartsWith: _):
            return version.rawValue
        case .character(host: _, version: let version, characterId: _):
            return version.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .characters(host: _, version: _, offset: _, nameStartsWith: _):
            return MUConstants.Api.Path.characters.rawValue
        case .character(host: _, version: _, characterId: let id):
            let str = String(format: MUConstants.Api.Path.characterById.rawValue, id)
            return str
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .characters(host: _, version: _, offset: _, nameStartsWith: _),
                .character(host: _, version: _, characterId: _):
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .characters(host: let host, version: _, offset: let offset, nameStartsWith: let nameStartsWith):
            var params = getParamsWithHost(host)
            params?.updateValue(offset,
                                forKey: MUConstants.Api.ParamKeys.offset.rawValue)
            if nameStartsWith != "" {
                params?.updateValue(nameStartsWith,
                                    forKey: MUConstants.Api.ParamKeys.nameStartsWith.rawValue)
            }
            params?.updateValue(MUConstants.Api.ConstantValues.apiLimitResult.rawValue,
                                forKey: MUConstants.Api.ParamKeys.limit.rawValue)
            return params
        case .character(host: let host, version: _, characterId: let id):
            var params = getParamsWithHost(host)
            params?.updateValue(id,
                                forKey: MUConstants.Api.ParamKeys.characterId.rawValue)
            return params
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    // MARK: -Private methods
    
    private func getURLWithHost(_ host: MUAPIHost) -> String {
        
        switch host {
        case .marvelUniverseApi:
            return MUConstants.Api.marvelHost.rawValue
        }
    }
    
    private func getParamsWithHost(_ host: MUAPIHost) -> [String : Any]? {
        
        switch host {
        case .marvelUniverseApi:
            if let publicKey = Bundle.main.object(forInfoDictionaryKey: MUConstants.Api.publicMarvelPlistKey.rawValue) as? String,
               let privateKey = Bundle.main.object(forInfoDictionaryKey: MUConstants.Api.privateMarvelPlistKey.rawValue) as? String {
                let timestamp = String(Date().timeIntervalSince1970)
                let hash = (timestamp + privateKey + publicKey).md5()
                let params = [
                    MUConstants.Api.ParamKeys.timestamp.rawValue : timestamp,
                    MUConstants.Api.ParamKeys.apikey.rawValue    : publicKey,
                    MUConstants.Api.ParamKeys.hash .rawValue     : hash
                ] as [String : Any]
                return params
            }
            return nil
        }
    }
    
  
}
