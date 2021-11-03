//
//  MUCharactersViewController.swift
//  marvel
//
//  Created by Daniel Moraleda on 26/10/21.
//

import UIKit

class MUCharactersViewController: MUBaseViewController {

    // MARK: -IBOutlets
    
    @IBOutlet weak var charactersTableView: UITableView! {
        didSet {
            charactersTableView.delegate = self
            charactersTableView.dataSource = self
            charactersTableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellId)
        }
    }
    
    // MARK: -Private constants
    
    private let cellNibName = "MUCharacterTableViewCell"
    private let cellId = "MUCharacterCellId"
    
    // MARK: -Private vars
    
    private var numberOfRows: Int {
        get {
            return charactersList.count
        }
    }
    private var charactersList = [MUCharacterUseCase]()
    private var searchController: UISearchController?
    private var searchText = "" {
        didSet {
            presenter?.searchCharactersByNameStarsWith(name: searchText)
        }
    }
    private var paginationView: UIView?
    private var paginationPreviousBtn: UIButton?
    private var paginationNextBtn: UIButton?
    private var paginationOffset: UILabel?
    private var paginationLimit: UILabel?
    private var paginationTotal: UILabel?
    private var paginationResultsCount: UILabel?
    
    // MARK: -Public vars
    
    var presenter: MUCharactersPresenterProtocol?
    
    // MARK: -Lifecycle
    
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
        title = MUConstants.ScreenName.characters.rawValue
    }
    
    private func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController?.searchBar
        searchBar?.tintColor = .black
        if let searchTextField = searchBar?.value(forKey: "searchField") as? UITextField {
            searchTextField.backgroundColor = UIColor.white
            searchTextField.textColor = UIColor.black
            let glassIconView = searchTextField.leftView as! UIImageView
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = .red
            if let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton {
                let templateImage =  clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
                clearButton.setImage(templateImage, for: [])
                clearButton.tintColor = .red
            }
        }
        searchBar?.delegate = self
        searchController?.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setPaginationView(offset: Int, total: Int, limit: Int) {
        if paginationView == nil {
            drawPaginationView()
        }
        if offset <= 1 {
            paginationPreviousBtn?.isHidden = true
        } else {
            paginationPreviousBtn?.isHidden = false
        }
        if (offset + limit) > total {
            paginationNextBtn?.isHidden = true
        } else {
            paginationNextBtn?.isHidden = false
        }
        paginationOffset?.text = "Offset  \(offset)"
        paginationLimit?.text = "Limit \(limit)"
        paginationTotal?.text = "Total \(total - 1)"
    }
    
    private func drawPaginationView() {
        paginationView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 60))
        paginationView?.backgroundColor = .red
        setupPaginationButtons()
        setupPaginationResults()
        paginationView?.addSubview(paginationPreviousBtn!)
        paginationView?.addSubview(paginationNextBtn!)
        paginationView?.addSubview(paginationOffset!)
        paginationView?.addSubview(paginationLimit!)
        paginationView?.addSubview(paginationTotal!)
    }
    
    private func setupPaginationButtons() {
        paginationPreviousBtn = UIButton(frame: CGRect(x: 10, y: 7, width: 50, height: 50))
        paginationNextBtn = UIButton(frame: CGRect(x: view.bounds.width - 60, y: 7, width: 50, height: 50))
        paginationPreviousBtn?.setupPaginationButtonWithTitle(
            "<<",
            bgColor: .white,
            titleColor: .red)
        paginationNextBtn?.setupPaginationButtonWithTitle(
            ">>",
            bgColor: .white,
            titleColor: .red)
        paginationPreviousBtn?.cornerRadius = 10
        paginationNextBtn?.cornerRadius = 10
        paginationPreviousBtn?.addTarget(self, action: #selector(prevPageTapped), for: .touchUpInside)
        paginationNextBtn?.addTarget(self, action: #selector(nextPageTapped), for: .touchUpInside)
    }
    
    private func setupPaginationResults() {
        paginationOffset = UILabel(frame: CGRect(x: 100, y: 5, width: view.bounds.width - 200, height: 15))
        paginationLimit = UILabel(frame: CGRect(x: 100, y: 25, width: view.bounds.width - 200, height: 15))
        paginationTotal = UILabel(frame: CGRect(x: 100, y: 45, width: view.bounds.width - 200, height: 15))
        paginationOffset?.textAlignment = .center
        paginationLimit?.textAlignment = .center
        paginationTotal?.textAlignment = .center
    }
    
    @objc private func nextPageTapped() {
        presenter?.loadNextPageRequest()
    }
    
    @objc private func prevPageTapped() {
        presenter?.loadPreviousPageRequest()
    }
}

// MARK: -MUCharactersViewControllerProtocol conformance

extension MUCharactersViewController: MUCharactersViewControllerProtocol {
    
    func getNavigation() -> UINavigationController? {
        if let navController = navigationController {
            return navController
        }
        return nil
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
    
    func displayCharacters(_ charactersList: [MUCharacterUseCase], offset: Int, total: Int, limit: Int) {
        self.charactersList = charactersList
        setPaginationView(offset: offset, total: total, limit: limit)
        charactersTableView.reloadData {
            if charactersList.count > 0 {
                self.charactersTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    func setupView() {
        setupNavigationBar()
        setupSearchBar()
    }
}

// MARK: - UISearchBar and UISearchControllerDelegate Delegate

extension MUCharactersViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text ?? ""
        searchController?.isActive = false
        searchBar.text = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchText != "" {
            searchText = ""
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = searchText
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Do nothing
    }
}

extension MUCharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MUCharacterTableViewCell
        cell.drawCell(charactersList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return paginationView
    }
}

extension MUCharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let characterDetailVC = SceneDelegate.sceneDelegate.dependencyInjManager.container.resolve(MUCharacterDetailViewController.self) {
            if let id = charactersList[indexPath.row].id {
                characterDetailVC.characterId = id
                presenter?.goToDetail(vc: characterDetailVC)
            }
        }
    }
}
