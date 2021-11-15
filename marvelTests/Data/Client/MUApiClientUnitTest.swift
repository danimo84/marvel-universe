//
//  MUApiClientUnitTest.swift
//  marvelTests
//
//  Created by Daniel Moraleda on 12/11/21.
//

import Quick
import Nimble
import Swinject
@testable import marvel

class MUApiClientUnitTest: QuickSpec {

    override func spec() {
        
        let container = Container()
        var apiClient: MUApiClient?
        
        beforeEach {
            container.register(MUApiClient.self) { resolver in
                MUApiClient()
            }
            apiClient = container.resolve(MUApiClient.self)
        }
        describe("when load characters is called") {
            context("given a valid protocol conformance, an offset, an empty name") {
                beforeEach {
                    apiClient?.fetchCharacters(offset: 0, nameStartsWith: "", { _, _ in})
                }
                it("should perform the network call") {}
            }
            context("given a valid protocol conformance, an offset, a name") {
                beforeEach {
                    apiClient?.fetchCharacters(offset: 0, nameStartsWith: "Capt", { _, _ in})
                }
                it("should perform the network call") {}
            }
        }
        describe("when load character by id is called") {
            context("given a valid protocol conformance, ") {
                beforeEach {
                    apiClient?.fetchCharacterWithId(1, { _, _ in})
                }
                it("sould perform the network call") {}
            }
        }
    }
}
