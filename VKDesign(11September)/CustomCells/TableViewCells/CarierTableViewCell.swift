//
//  CarierTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 23/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class CarierTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationAndPeriodLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    func prepareCell(with item: InformationViewModelCarierItem) {
        companyLabel.text = item.company
        locationAndPeriodLabel.text = item.locationAndPeriod
        positionLabel.text = item.position
    }
}
