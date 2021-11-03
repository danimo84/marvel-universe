//
//  MUCharactersPresenter.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import UIKit

final class MUCharactersPresenter: MUBasePresenter {
    
    // MARK: -Private vars
    
    private var loadCharactersUseCaseInProgress = false {
        didSet {
            if loadCharactersUseCaseInProgress {
                DispatchQueue.main.async { self.view?.showLoading() }
            } else {
                DispatchQueue.main.async { self.view?.hideLoading() }
            }
        }
    }
    private var currentOffset = 1
    private var offset = 1
    private var limit = 0
    private var total: Int?
    private var searchString = ""
    private var characters = [MUCharacterUseCase]()
    
    // MARK: -Public vars
    
    weak var view: MUCharactersViewControllerProtocol?
    var loadCharactersUseCase: MULoadCharactersUseCaseProtocol?
    var router: MUCharactersRouterProtocol?
    
    // MARK: -Private methods
    
    private func loadCharacterList() {
        
        DispatchQueue.global(qos: .background).async {
            self.loadCharactersUseCaseInProgress = true
            self.loadCharactersUseCase?.execute(offset: self.offset, nameStartsWith: self.searchString, { response, error in
                self.loadCharactersUseCaseInProgress = false
                if let errorReturned = error {
                    DispatchQueue.main.async {
                        self.view?.showError(exception: errorReturned)
                    }
                } else if let charactersUseCase = response {
                    DispatchQueue.main.async {
                        self.setResponseInfoAndDisplay(charactersUseCase: charactersUseCase)
                    }
                }
            })
        }
    }
    
    private func setResponseInfoAndDisplay(charactersUseCase: MUCharacterResultUseCase) {
        currentOffset = offset
        offset += charactersUseCase.count ?? 0
        total = charactersUseCase.total
        limit = charactersUseCase.limit ?? 0
        characters.append(contentsOf: charactersUseCase.characters ?? [MUCharacterUseCase]())
        view?.displayCharacters(characters, offset: currentOffset, total: total ?? 0, limit: limit)
    }
}

// MARK: -CharactersPresenterProtocol conformance

extension MUCharactersPresenter: MUCharactersPresenterProtocol {
    
    func viewDidLoad() {
        view?.setupView()
        if let navController = view?.getNavigation() {
            router?.setNavController(navController)
        }
        loadCharacters()
    }
    
    func bind(view: MUCharactersViewControllerProtocol) {
        self.view = view
    }
    
    func loadCharacters() {
        loadCharacterList()
    }
    
    func goToDetail(vc: UIViewController) {
        router?.goTo(vc)
    }
    
    func searchCharactersByNameStarsWith(name: String) {
        total = nil
        offset = 1
        characters = [MUCharacterUseCase]()
        searchString = name
        loadCharacters()
    }
    
    func loadNextPageRequest() {
        total = nil
        characters = [MUCharacterUseCase]()
        loadCharacters()
    }
    
    func loadPreviousPageRequest() {
        total = nil
        offset = currentOffset - limit
        characters = [MUCharacterUseCase]()
        loadCharacters()
    }
}
