//
//  UIColor+Extension.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 10/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var Main: UIColor {
        return UIColor(red: 74 / 255.0, green: 163 / 255.0, blue: 243 / 255.0, alpha: 1.0)
    }
    
    class var Gray: UIColor {
        return UIColor(red: 242 / 255.0, green: 243 / 255.0, blue: 248 / 255.0, alpha: 1.0)
    }
    
    class func RGB_COLOR(_ r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}
