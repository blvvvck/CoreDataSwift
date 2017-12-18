//
//  InformationViewModelMoreInfoItem.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 25/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation

struct InformationViewModelMoreInfoItem: InformationViewModelItem {
    var type: InformationViewModelItemType {
        return .moreInfo
    }
    
    var sectionType: String {
        return ""
    }
    
    var rowCount: Int {
        return 3
    }
    
    var moreInformations: [MoreInfo]
}


