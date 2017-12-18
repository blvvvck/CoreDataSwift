//
//  MainInfoTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 22/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class MainInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func prepareCell(with mainInfoModel: MainInfo) {
        subtitleLabel.text = mainInfoModel.info
        titleLabel.text = mainInfoModel.title
    }
}
