//
//  UIButtonExtension.swift
//  Ordering
//
//  Created by Michael Wild on 13/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    class func defaultHeight () -> CGFloat{
        return 50
    }
    
    func defaultStyle ( ) {
        self.backgroundColor = ColorHelper.mainColor
    }
    
    func secondaryDefaultStyle ( ) {
        self.backgroundColor = .clear
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.setTitleColor(UIColor.darkGray, for: UIControlState())
        self.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        
    }
    
}
