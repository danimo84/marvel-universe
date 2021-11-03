//
//  MUConstants.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation

enum MUConstants {
    
    enum Api: String {
        
        case publicMarvelPlistKey = "Public Marvel Api Key"
        case privateMarvelPlistKey = "Private Marvel Api Key"
        case marvelHost = "https://gateway.marvel.com:443"
        
        enum Path: String {

            case characters = "public/characters"
            case characterById = "public/characters/%d"
        }
        
        enum ParamKeys: String {
            
            case offset = "offset"
            case limit = "limit"
            case nameStartsWith = "nameStartsWith"
            case timestamp = "ts"
            case apikey = "apikey"
            case hash = "hash"
            case characterId = "characterId"
        }
        
        enum ConstantValues: Int {
            
            case apiLimitResult = 50
        }
    }
    
    enum ImageName: String {
        
        case marvelLogo = "marvel_studios_logo"
    }
    
    enum ScreenName: String {
        
        case characters = "Characters"
    }
}
