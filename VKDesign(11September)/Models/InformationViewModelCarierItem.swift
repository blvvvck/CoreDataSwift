//
//  InformationViewModelCarierItem.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 25/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation

struct InformationViewModelCarierItem: InformationViewModelItem {
    var type: InformationViewModelItemType {
        return .carier
    }
    
    var sectionType: String {
        return "КАРЬЕРА"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var company: String
    var locationAndPeriod: String
    var position: String
}
