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
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
