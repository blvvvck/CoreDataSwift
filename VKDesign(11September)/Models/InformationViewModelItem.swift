//
//  InformationViewModelItem.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 25/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation
import UIKit

protocol InformationViewModelItem {
    var type: InformationViewModelItemType { get }
    var sectionType: String { get }
    var rowCount: Int { get }
}
