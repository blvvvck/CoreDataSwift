//
//  ContactsTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 23/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    
    func prepareCell(with contactModel: Contacts) {
        iconImageView.image = contactModel.image
        contactLabel.text = contactModel.contact
    }
}
