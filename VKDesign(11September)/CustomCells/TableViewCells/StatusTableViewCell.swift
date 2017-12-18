//
//  StatusTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 22/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    @IBOutlet weak var statusLabel: UILabel!
    
    func prepateCell(with item: InformationViewModelStatusItem){
        statusLabel.text = item.status
    }
}
