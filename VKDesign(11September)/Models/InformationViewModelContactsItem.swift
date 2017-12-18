//
//  InformationViewModelContactsItem.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 25/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation
import UIKit

struct InformationViewModelContactsItem: InformationViewModelItem {
    var type: InformationViewModelItemType {
        return .contacts
    }
    
    var sectionType: String {
        return "КОНТАКТЫ"
    }
    
    var rowCount: Int {
        return contacts.count
    }
    
    var contacts: [Contacts]
}

