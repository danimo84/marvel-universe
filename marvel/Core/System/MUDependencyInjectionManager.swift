//
//  MUDependencyInjectionManager.swift
//  marvel
//
//  Created by Daniel Moraleda on 26/10/21.
//

import Swinject

/// Manager used for injecting all the dependencies in the project
class MUDependencyInjectionManager {
    
    // MARK: Constants
    
    let container = Container()
    
    // MARK: Initializers
    
    init() {
        registerViewControllers()
        registerPresenters()
        registerRouters()
        registerUseCases()
        registerProviders()
        registerDataSources()
        registerClients()
    }
    
    // MARK: Private methods
    
    private func registerViewControllers() {
        container.register(MUCharactersViewController.self) { resolver in
            let vc = MUCharactersViewController()
            vc.presenter = resolver.resolve(MUCharactersPresenterProtocol.self)
            return vc
        }
        container.register(MUCharacterDetailViewController.self) { resolver in
            let vc = MUCharacterDetailViewController()
            vc.presenter = resolver.resolve(MUCharacterDetailPresenterProtocol.self)
            return vc
        }
    }
    
    private func registerPresenters() {
        container.register(MUCharactersPresenterProtocol.self) { resolver in
            let presenter = MUCharactersPresenter()
            presenter.loadCharactersUseCase = resolver.resolve(MULoadCharactersUseCaseProtocol.self)
            presenter.router = resolver.resolve(MUCharactersRouterProtocol.self)
            return presenter
        }
        container.register(MUCharacterDetailPresenterProtocol.self) { resolver in
            let presenter = MUCharacterDetailPresenter()
            presenter.loadCharacterDetailUseCase = resolver.resolve(MULoadCharacterDetailUseCaseProtocol.self)
            presenter.router = resolver.resolve(MUCharacterDetailRouterProtocol.self)
            return presenter
        }
    }
    
    private func registerRouters() {
        container.register(MUCharactersRouterProtocol.self) { resolver in
            return MUCharactersRouter()
        }
        container.register(MUCharacterDetailRouterProtocol.self) { resolver in
            return MUCharacterDetailRouter()
        }
    }
    
    private func registerUseCases() {
        container.register(MULoadCharactersUseCaseProtocol.self) { resolver in
            let useCase = MULoadCharactersUseCase()
            useCase.characterProvider = resolver.resolve(MUCharacterProviderProtocol.self)
            return useCase
        }
        container.register(MULoadCharacterDetailUseCaseProtocol.self) { resolver in
            let useCase = MULoadCharacterDetailUseCase()
            useCase.characterDetailProvider = resolver.resolve(MUCharacterDetailProviderProtocol.self)
            return useCase
        }
    }
    
    private func registerProviders() {
        container.register(MUNetworkProviderProtocol.self) { resolver in
            return MUNetworkProvider()
        }
        container.register(MUCharacterProviderProtocol.self) { resolver in
            let provider = MUCharacterProvider()
            provider.remoteDataSource = resolver.resolve(MURemoteDataSourceProtocol.self)
            return provider
        }
        container.register(MUCharacterDetailProviderProtocol.self) { resolver in
            let provider = MUCharacterDetailProvider()
            provider.remoteDataSource = resolver.resolve(MURemoteDataSourceProtocol.self)
            return provider
        }
    }
    
    private func registerDataSources() {
        container.register(MURemoteDataSourceProtocol.self) { resolver in
            let dataSource = MURemoteDataSource()
            dataSource.apiClient = resolver.resolve(MUApiClientProtocol.self)
            return dataSource
        }
    }
    
    private func registerClients() {
        container.register(MUApiClientProtocol.self) { resolver in
            return MUApiClient()
        }.inObjectScope(.container)
    }
}
