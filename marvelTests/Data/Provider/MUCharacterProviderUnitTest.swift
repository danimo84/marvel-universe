//
//  MUCharacterProviderUnitTest.swift
//  marvelTests
//
//  Created by Daniel Moraleda on 13/11/21.
//

import Quick
import Nimble
import Swinject
@testable import marvel

class MUCharacterProviderUnitTest: QuickSpec {
    
    override func spec() {
        
        let container = Container()
        var characterProvider: MUCharacterProvider?
        var remoteDataSource: MUMockRemoteDataSource?
        
        beforeEach {
            container.register(MUCharacterProvider.self) { resolve in
                let characterProvider = MUCharacterProvider()
                characterProvider.remoteDataSource = resolve.resolve(MUMockRemoteDataSource.self)
                return characterProvider
            }
            container.register(MUMockRemoteDataSource.self) { resolve in
                MUMockRemoteDataSource()
            }
            characterProvider = container.resolve(MUCharacterProvider.self)
            remoteDataSource = container.resolve(MUMockRemoteDataSource.self)
        }
        
        describe("when fetch characters is called") {
            context("given a valid protocol, an offset and a nameStartWith") {
                beforeEach {
                    characterProvider?.remoteDataSource = remoteDataSource
                    characterProvider?.fetchCharacters(offset: 0, nameStartsWith: "cap", { _, _ in })
                }
                it("should call fetch characters remote data source method") {
                    expect(remoteDataSource?.fetchCharactersIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        remoteDataSource?.fetchCharacters(offset: 0, nameStartsWith: "cap", { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
            }
            context("given a valid protocol, an offset, a nameStartWith and an exception") {
                beforeEach {
                    remoteDataSource?.isThrowing = true
                    characterProvider?.remoteDataSource = remoteDataSource
                    characterProvider?.fetchCharacters(offset: 0, nameStartsWith: "", { _, _ in })
                }
                it("should call fetch characters remote data source method") {
                    expect(remoteDataSource?.fetchCharactersIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        remoteDataSource?.fetchCharacters(offset: 0, nameStartsWith: "", { response, error in
                            expect(response).to(beNil())
                            expect(error).notTo(beNil())
                            done()
                        })
                    }
                }
            }
        }
    }
}
