//
//  GSViewDashLine.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 12/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit

class GSViewDashLine: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 0)
        
        UIColor.white.setFill()
        path.fill()
        
        UIColor.gray.setStroke()
        path.lineWidth = 2
        
        let dashPattern : [CGFloat] = [2, 4]
        path.setLineDash(dashPattern, count: 2, phase: 0)
        path.stroke()
    }
}
