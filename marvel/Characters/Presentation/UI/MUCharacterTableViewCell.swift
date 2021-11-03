//
//  MUCharacterTableViewCell.swift
//  marvel
//
//  Created by Daniel Moraleda on 31/10/21.
//

import UIKit
import AlamofireImage

class MUCharacterTableViewCell: UITableViewCell {

    // MARK: -IBOutlets
    
    @IBOutlet weak var characterImgView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    func drawCell(_ character: MUCharacterUseCase) {
        if let name = character.name {
            characterNameLabel.text = name
        }
        if let desc = character.description {
            characterDescriptionLabel.text = desc
        }
        if let imgString = character.thumbnail, let imgUrl = URL(string: imgString) {
            characterImgView.af.setImage(
                withURL: imgUrl,
                placeholderImage: UIImage(
                    named: MUConstants.ImageName.marvelLogo.rawValue
                )
            )
        }
    }
}
