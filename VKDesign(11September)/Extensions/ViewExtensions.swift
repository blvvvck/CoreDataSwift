//
//  ViewExtensions.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 15/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
