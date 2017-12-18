//
//  UserPhotoCollectionViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 22/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class UserPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!

    func prepareCell(with photo: UIImage) {
        photoImageView.image = photo
    }

}
