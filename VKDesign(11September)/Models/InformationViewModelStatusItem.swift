//
//  InformationViewModelStatusItem.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 25/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation

struct InformationViewModelStatusItem: InformationViewModelItem {

        var type: InformationViewModelItemType {
            return .status
        }
        
        var sectionType: String {
            return ""
        }
        
        var rowCount: Int{
            return 1
        }
        
        var status: String
}
