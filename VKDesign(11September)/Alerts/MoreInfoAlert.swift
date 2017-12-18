//
//  moreMoreInfoAlert.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 06/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation
import UIKit

func showMoreInfoAlert() -> UIAlertController {
    let editTitle = "Редактировать профиль"
    let copyTitle = "Скопировать ссылку"
    let shareTitle = "Поделиться..."
    let cancelTitle = "Отмена"
    
    let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    let editAction = UIAlertAction(title: editTitle, style: .default, handler: nil)
    
    let copyAction = UIAlertAction(title: copyTitle, style: .default, handler: nil)
    
    let shareAction = UIAlertAction(title: shareTitle, style: .default, handler: nil)
    
    let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
    
    optionMenu.addAction(editAction)
    optionMenu.addAction(copyAction)
    optionMenu.addAction(shareAction)
    optionMenu.addAction(cancelAction)
    
    return optionMenu
}
