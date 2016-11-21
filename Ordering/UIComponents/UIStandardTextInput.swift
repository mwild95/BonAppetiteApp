//
//  UIStandardTextInput.swift
//  Ordering
//
//  Created by Michael Wild on 12/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func standardStyle () {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    class func defaultHeight () -> CGFloat{
        return 31
    }
    

}
