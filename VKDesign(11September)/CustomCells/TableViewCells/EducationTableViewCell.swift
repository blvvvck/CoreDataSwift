//
//  EducationTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 24/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class EducationTableViewCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func prepareCell(with educationalModel: EducationalEstablishments) {
        typeLabel.text = educationalModel.type
        nameLabel.text = educationalModel.name
    }
}
