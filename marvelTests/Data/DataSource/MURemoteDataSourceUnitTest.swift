//
//  MURemoteDataSourceUnitTest.swift
//  marvelTests
//
//  Created by Daniel Moraleda on 12/11/21.
//

import Quick
import Nimble
import Swinject
@testable import marvel

class MURemoteDataSourceUnitTest: QuickSpec {
    
    override func spec() {
        
        let container = Container()
        var dataSource: MURemoteDataSource?
        var apiClient: MUMockApiClient?
        
        beforeEach {
            container.register(MURemoteDataSource.self) { resolver in
                let dataSource = MURemoteDataSource()
                dataSource.apiClient = resolver.resolve(MUMockApiClient.self)
                return dataSource
            }
            container.register(MUMockApiClient.self) { resolver in
                MUMockApiClient()
            }
            dataSource = container.resolve(MURemoteDataSource.self)
            apiClient = container.resolve(MUMockApiClient.self)
        }
        describe("when fetch characters is called") {
            context("given a valid protocol conformance, an offset and a empty name") {
                beforeEach {
                    dataSource?.apiClient = apiClient
                    dataSource?.fetchCharacters(offset: 0, nameStartsWith: "", { _, _ in})
                }
                it("should call fetch characters api client method") {
                    expect(apiClient?.fetchCharactersIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        apiClient?.fetchCharacters(offset: 0, nameStartsWith: "", { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
            }
            context("when fetch characters is called") {
                beforeEach {
                    apiClient?.isThrowing = true
                    dataSource?.apiClient = apiClient
                    dataSource?.fetchCharacters(offset: 0, nameStartsWith: "", { _, _ in})
                }
                it("should call fetch characters api client method") {
                    expect(apiClient?.fetchCharactersIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        apiClient?.fetchCharacters(offset: 0, nameStartsWith: "", { response, error in
                            expect(response).to(beNil())
                            expect(error).notTo(beNil())
                            done()
                        })
                    }
                }
            }
            
        }
        describe("when fetch character by id is called") {
            context("given a valid protocol conformance and a charcter id") {
                beforeEach {
                    dataSource?.apiClient = apiClient
                    dataSource?.fetchCharacterWithId(12, { _, _ in})
                }
                it("should call fetch character by id api client method") {
                    expect(apiClient?.fetchCharacterByIdIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        apiClient?.fetchCharacterWithId(12, { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
            }
            context("given a valid protocol conformance, a character id and an exception") {
                beforeEach {
                    apiClient?.isThrowing = true
                    dataSource?.apiClient = apiClient
                    dataSource?.fetchCharacterWithId(12, { _, _ in})
                }
                it("should call fetch character by id api client method") {
                    expect(apiClient?.fetchCharacterByIdIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        apiClient?.fetchCharacterWithId(12, { response, error in
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
