//
//  InformationViewModelGiftsItem.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 25/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation

struct InformationViewModelGiftsItem: InformationViewModelItem {
    var type: InformationViewModelItemType {
        return .gifts
    }
    
    var sectionType: String {
        return ""
    }
    
    var rowCount: Int {
        return 1
    }
    
    var giftNumbers: String
}
