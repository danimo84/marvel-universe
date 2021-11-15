//
//  MUCharacterDetailProviderUnitTest.swift
//  marvelTests
//
//  Created by Daniel Moraleda on 13/11/21.
//

import Quick
import Nimble
import Swinject
@testable import marvel

class MUCharacterDetailProviderUnitTest: QuickSpec {

    override func spec() {
        
        let container = Container()
        var characterDetailProvider: MUCharacterDetailProvider?
        var remoteDataSource: MUMockRemoteDataSource?
        
        beforeEach {
            container.register(MUCharacterDetailProvider.self) { resolve in
                let characterDetailProvider = MUCharacterDetailProvider()
                characterDetailProvider.remoteDataSource = resolve.resolve(MUMockRemoteDataSource.self)
                return characterDetailProvider
            }
            container.register(MUMockRemoteDataSource.self) { resolve in
                MUMockRemoteDataSource()
            }
            characterDetailProvider = container.resolve(MUCharacterDetailProvider.self)
            remoteDataSource = container.resolve(MUMockRemoteDataSource.self)
        }
        
        describe("when fetch character by id is called") {
            context("given a valid protocol and a character id") {
                beforeEach {
                    characterDetailProvider?.remoteDataSource = remoteDataSource
                    characterDetailProvider?.fetchsCharacterWithId(123, { _, _ in })
                }
                it("should call fetch character by id remote data source method") {
                    expect(remoteDataSource?.fetchCharacterByIdIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        remoteDataSource?.fetchCharacterWithId(123, { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
            }
            context("given a valid protocol, a character id and an exception") {
                beforeEach {
                    remoteDataSource?.isThrowing = true
                    characterDetailProvider?.remoteDataSource = remoteDataSource
                    characterDetailProvider?.fetchsCharacterWithId(123, { _, _ in })
                }
                it("should call fetch character by id remote data source method") {
                    expect(remoteDataSource?.fetchCharacterByIdIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        remoteDataSource?.fetchCharacterWithId(123, { response, error in
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
