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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var comicsButton: UIButton!
    @IBOutlet weak var seriesButton: UIButton!
    @IBOutlet weak var storiesButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var selectedItemLabel: UILabel!
    @IBOutlet weak var itemsCollectionView: UICollectionView! {
        didSet {
            itemsCollectionView.register(UINib(nibName: cellNibName, bundle: nil), forCellWithReuseIdentifier: cellId)
            itemsCollectionView.delegate = self
            itemsCollectionView.dataSource = self
        }
    }
    
    // MARK: -Private constants
    
    private let cellId = "MUItemCollectionCellId"
    private let cellNibName = "MUItemCollectionViewCell"
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)
    private let itemsPerRow: CGFloat = 3
    weak var collectionCell: MUItemCollectionViewCell?
    
    // MARK: -Private vars
    
    private var character = MUCharacterDetailUseCase() {
        didSet {
            setupNavigationBar()
        }
    }
    private var itemSelected = 0
    private enum MUItemButtonTag: Int {
        case comic = 0
        case serie = 1
        case story = 2
        case event = 3
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
    
    private func getAttributedButtonTitle(_ title: String) -> NSAttributedString {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attrString = NSAttributedString(string: title, attributes: [.paragraphStyle: paragraph, .font: UIFont(name: "Helvetica", size: 12)!])
        return attrString
    }
    
    private func getItemTitle(item: Int) -> String {
        
        switch itemSelected {
        case MUItemButtonTag.comic.rawValue:
            return character.comics?.items?[item].name ?? ""
        case MUItemButtonTag.serie.rawValue:
            return character.series?.items?[item].name ?? ""
        case MUItemButtonTag.story.rawValue:
            return character.stories?.items?[item].name ?? ""
        case MUItemButtonTag.event.rawValue:
            return character.events?.items?[item].name ?? ""
        default:
            return ""
        }
    }
    
    private func getButtonTitle(tag: Int) {
        switch itemSelected {
        case MUItemButtonTag.comic.rawValue:
            selectedItemLabel.text = "Comics"
        case MUItemButtonTag.serie.rawValue:
            selectedItemLabel.text = "Series"
        case MUItemButtonTag.story.rawValue:
            selectedItemLabel.text = "Stories"
        case MUItemButtonTag.event.rawValue:
            selectedItemLabel.text = "Events"
        default:
            selectedItemLabel.text = ""
        }
    }
    
    @IBAction func selectorTapped(_ sender: Any) {
        
        if let button = sender as? UIButton {
            itemSelected = button.tag
            getButtonTitle(tag: button.tag)
            itemsCollectionView.reloadData()
        }
        
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
            if let desc = character.description {
                descriptionLabel.text = desc
                if desc == "" {
                    descriptionLabel.text = "📝 No description found 📝"
                }
            }
            if let comicsCount = character.comics?.items?.count {
                comicsButton.setAttributedTitle(getAttributedButtonTitle("Comics (\(comicsCount))"), for: .normal)
            }
            if let seriesCount = character.series?.items?.count {
                seriesButton.setAttributedTitle(getAttributedButtonTitle("Series (\(seriesCount))"), for: .normal)
            }
            if let storiesCount = character.stories?.items?.count {
                storiesButton.setAttributedTitle(getAttributedButtonTitle("Stories (\(storiesCount))"), for: .normal)
            }
            if let eventsCount = character.events?.items?.count {
                eventsButton.setAttributedTitle(getAttributedButtonTitle("Events (\(eventsCount))"), for: .normal)
            }
            itemsCollectionView.reloadData()
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

extension MUCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch itemSelected {
        case MUItemButtonTag.comic.rawValue:
            return character.comics?.items?.count ?? 0
        case MUItemButtonTag.serie.rawValue:
            return character.series?.items?.count ?? 0
        case MUItemButtonTag.story.rawValue:
            return character.stories?.items?.count ?? 0
        case MUItemButtonTag.event.rawValue:
            return character.events?.items?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MUItemCollectionViewCell
        cell.drawTitle(getItemTitle(item: indexPath.item))
        return cell
    }
}

extension MUCharacterDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
}
