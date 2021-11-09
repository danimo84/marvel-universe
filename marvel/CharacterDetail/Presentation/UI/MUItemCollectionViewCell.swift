//
//  MUItemCollectionViewCell.swift
//  marvel
//
//  Created by Daniel Moraleda on 9/11/21.
//

import UIKit

class MUItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func drawTitle(_ title: String) {
        
        itemTitleLabel.text = title
    }

}
