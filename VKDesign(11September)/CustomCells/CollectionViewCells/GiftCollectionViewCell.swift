//
//  GiftCollectionViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 23/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class GiftCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var giftImageView: UIImageView!
    
    func prepareCell(with photo: UIImage) {
        giftImageView.image = photo
    }
}
