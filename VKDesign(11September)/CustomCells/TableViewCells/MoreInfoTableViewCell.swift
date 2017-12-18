//
//  MoreInfoTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 24/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class MoreInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func prepareCell(with moreInfoModel: MoreInfo) {
        titleLabel.text = moreInfoModel.title
        countLabel.text = moreInfoModel.count        
    }
}
