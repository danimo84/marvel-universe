//
//  MUCharacterDetailUseCaseUnitTest.swift
//  marvelTests
//
//  Created by Daniel Moraleda on 14/11/21.
//

import Quick
import Nimble
import Swinject
@testable import marvel

class MUCharacterDetailUseCaseUnitTest: QuickSpec {

    override func spec() {
        
        let container = Container()
        var useCase: MULoadCharacterDetailUseCase?
        var characterDetailProvider: MUMockCharacterDetailProvider?
        
        beforeEach {
            container.register(MULoadCharacterDetailUseCase.self) { resolver in
                let useCase = MULoadCharacterDetailUseCase()
                useCase.characterDetailProvider = resolver.resolve(MUMockCharacterDetailProvider.self)
                return useCase
            }
            container.register(MUMockCharacterDetailProvider.self) { resolver in
                MUMockCharacterDetailProvider()
            }
            useCase = container.resolve(MULoadCharacterDetailUseCase.self)
            characterDetailProvider = container.resolve(MUMockCharacterDetailProvider.self)
        }
        describe("when execute character detail use case is called") {
            context("given a valid protocol conformance and a valid response from character detail provider") {
                beforeEach {
                    useCase?.characterDetailProvider = characterDetailProvider
                    useCase?.execute(characterId: 12, completion: { _, _ in })
                }
                it("should call fetch character detail from character detail provider method") {
                    expect(characterDetailProvider?.fetchCharacterByIdIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        characterDetailProvider?.fetchsCharacterWithId(12, { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
            }
            context("given a valid protocol conformance and a error response from character detail provider") {
                beforeEach {
                    characterDetailProvider?.isThrowing = true
                    useCase?.characterDetailProvider = characterDetailProvider
                    useCase?.execute(characterId: 0, completion: { _, _ in })
                }
                it("should call fetch character detail from character detail provider method") {
                    expect(characterDetailProvider?.fetchCharacterByIdIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        characterDetailProvider?.fetchsCharacterWithId(12, { response, error in
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
