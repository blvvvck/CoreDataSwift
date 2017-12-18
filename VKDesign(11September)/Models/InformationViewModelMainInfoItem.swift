//
//  InformationViewModelMainInfoItem.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 25/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation

struct InformationViewModelMainInfoItem: InformationViewModelItem {
    var type: InformationViewModelItemType {
        return .mainInfo
    }
    
    var sectionType: String {
        return ""
    }
    
    var rowCount: Int{
        return mainInformations.count
    }
    
    var mainInformations: [MainInfo]
}

