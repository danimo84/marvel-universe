//
//  MUCharacterDetailViewController.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import UIKit

class MUCharacterDetailViewController: MUBaseViewController {

    // MARK: -IBOutlets
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var comicsButton: UIButton!
    @IBOutlet weak var seriesButton: UIButton!
    
    // MARK: -Private vars
    
    private var character = MUCharacterDetailUseCase() {
        didSet {
            setupNavigationBar()
        }
    }
  
    // MARK: -Public vars
    
    var presenter: MUCharacterDetailPresenterProtocol?
    var characterId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindPresenter()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
    }
    
    // MARK: -Private methods
    
    private func bindPresenter() {
        presenter?.bind(view: self)
    }
    
    private func setupNavigationBar() {
        title = character.name
    }
}

// MARK: -MUCharacterDetailViewControllerProtocol conformance

extension MUCharacterDetailViewController: MUCharacterDetailViewControllerProtocol {
    
    func setupView() {
        setupNavigationBar()
    }
    
    func showLoading() {
        showLoadingMask()
    }
    
    func hideLoading() {
        hideLoadingMask()
    }
    
    func showError(exception: MUAPIException?) {
        showAlert(title: "Error", mssg: exception?.localizedDescription ?? "Unknown Error")
    }
    
    func displayCharacter(_ characters: [MUCharacterDetailUseCase]) {
        if let character = characters.first {
            self.character = character
            if let imgString = character.thumbnail, let imgUrl = URL(string: imgString) {
                characterImage.af.setImage(withURL: imgUrl)
            }
            if let comicsCount = character.comics?.items?.count {
                comicsButton.setTitle("Comics (\(comicsCount))", for: .normal)
            }
            if let seriesCount = character.series?.items?.count {
                seriesButton.setTitle("Series (\(seriesCount))", for: .normal)
            }
        }
    }
    
    func getCharacterId() -> Int {
        return characterId
    }
    
    func getNavigation() -> UINavigationController? {
        if let navController = navigationController {
            return navController
        }
        return nil
    }
}
