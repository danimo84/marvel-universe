//
//  MUCharacterDetailPresenter.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import Foundation

final class MUCharacterDetailPresenter: MUBasePresenter {
    
    // MARK: -Private vars
    
    private var loadCharacterDetailUseCaseInProgress = false {
        didSet {
            if loadCharacterDetailUseCaseInProgress {
                DispatchQueue.main.async {
                    self.view?.showLoading()
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.hideLoading()
                }
            }
        }
    }
    private var character = MUCharacterDetailUseCase()
    
    // MARK: -Public vars
    
    weak var view: MUCharacterDetailViewControllerProtocol?
    var loadCharacterDetailUseCase: MULoadCharacterDetailUseCaseProtocol?
    var router: MUCharacterDetailRouterProtocol?
    
    // MARK: -Private methods
    
    private func loadCharacterDetail() {
        
        DispatchQueue.global(qos: .background).async {
            
            self.loadCharacterDetailUseCaseInProgress = true
            self.loadCharacterDetailUseCase?.execute(characterId: self.view?.getCharacterId() ?? 0, completion: { response, error in
                self.loadCharacterDetailUseCaseInProgress = false
                if let errorReturned = error {
                    DispatchQueue.main.async {
                        self.view?.showError(exception: errorReturned)
                    }
                } else if let characterDetailUseCase = response {
                    DispatchQueue.main.async {
                        self.setResponseInfoAndDisplay(characterDetailResultUseCase: characterDetailUseCase)
                    }
                }
            })
        }
    }
    
    private func setResponseInfoAndDisplay(characterDetailResultUseCase: MUCharacterDetailResultUseCase) {
        
        if let characterDetail = characterDetailResultUseCase.characters?.first {
            character = characterDetail
            if let characters = characterDetailResultUseCase.characters {
                view?.displayCharacter(characters)
            }
        }
    }
}

// MARK: -MUCharacterDetailPresenterProtocol conformance

extension MUCharacterDetailPresenter: MUCharacterDetailPresenterProtocol {
    
    func bind(view: MUCharacterDetailViewControllerProtocol) {
        self.view = view
    }
    
    func loadCharacter() {
        loadCharacterDetail()
    }
    
    
    func viewDidLoad() {
        view?.setupView()
        if let navController = view?.getNavigation() {
            router?.setNavController(navController)
        }
        loadCharacter()
    }
}
