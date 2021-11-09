//
//  MUCharacterDetailUseCase.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

class MUCharacterDetailUseCase: MUCharacterUseCase {
    
    var series: MUCharacterDetailSerieUseCase?
    var comics: MUCharacterDetailComicUseCase?
    var stories: MUCharacterDetailStoryUseCase?
    var events: MUCharacterDetailEventUseCase?
    
    override init() {
        series = nil
        comics = nil
        stories = nil
        events = nil
    }
}
