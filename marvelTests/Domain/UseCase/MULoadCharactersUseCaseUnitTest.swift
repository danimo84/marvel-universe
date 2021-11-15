//
//  MULoadCharactersUseCaseUnitTest.swift
//  marvelTests
//
//  Created by Daniel Moraleda on 14/11/21.
//

import Quick
import Nimble
import Swinject
@testable import marvel

class MULoadCharactersUseCaseUnitTest: QuickSpec {

    override func spec() {
        
        let container = Container()
        var useCase: MULoadCharactersUseCase?
        var characterProvider: MUMockCharacterProvider?
        
        beforeEach {
            container.register(MULoadCharactersUseCase.self) { resolver in
                let useCase = MULoadCharactersUseCase()
                useCase.characterProvider = resolver.resolve(MUMockCharacterProvider.self)
                return useCase
            }
            container.register(MUMockCharacterProvider.self) { resolver in
                MUMockCharacterProvider()
            }
            useCase = container.resolve(MULoadCharactersUseCase.self)
            characterProvider = container.resolve(MUMockCharacterProvider.self)
        }
        describe("when execute character use case is called") {
            context("given a valid protocol conformance and a valid response from character provider") {
                beforeEach {
                    useCase?.characterProvider = characterProvider
                    useCase?.execute(offset: 0, nameStartsWith: "cap", { _, _ in })
                }
                it("should call fetch characters from character provider method") {
                    expect(characterProvider?.fetchCharactersIsCalled).to(beTrue())
                }
                it("callback should be a success response") {
                    waitUntil { done in
                        characterProvider?.fetchCharacters(offset: 0, nameStartsWith: "", { response, error in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
            }
            context("given a valid protocol conformance and a error response from character provider") {
                beforeEach {
                    characterProvider?.isThrowing = true
                    useCase?.characterProvider = characterProvider
                    useCase?.execute(offset: 0, nameStartsWith: "cap", { _, _ in })
                }
                it("should call fetch characters from character provider method") {
                    expect(characterProvider?.fetchCharactersIsCalled).to(beTrue())
                }
                it("callback should be an exception") {
                    waitUntil { done in
                        characterProvider?.fetchCharacters(offset: 0, nameStartsWith: "", { response, error in
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
