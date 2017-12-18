//
//  InformationViewModelEducationItem.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 25/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation

struct InformationViewModelEducationItem: InformationViewModelItem {
    var type: InformationViewModelItemType {
        return .education
    }
    
    var sectionType: String {
        return "ОБРАЗОВАНИЕ"
    }
    
    var rowCount: Int {
        return 2
    }
    
    var educationaEstablishments: [EducationalEstablishments]
}


