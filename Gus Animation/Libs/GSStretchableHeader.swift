//
//  GSStretchableHeader.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 10/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit

public class GSStretchableHeader: NSObject {
    
    private var stretchedView = UIView()
    private var imageRatio: CGFloat = 0
    private var originFrame = CGRect()
    
    public init(stretchedView: UIView) {
        self.stretchedView  = stretchedView
        self.originFrame    = stretchedView.frame
        self.imageRatio     = stretchedView.bounds.height / stretchedView.bounds.width
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let getYOffset = scrollView.contentOffset.y
        if getYOffset > 0 {
            var frame                   = self.originFrame
            frame.origin.y              = self.originFrame.origin.y - getYOffset
            self.stretchedView.frame    = frame
        } else {
            var frame = self.originFrame
            frame.size.height           = self.originFrame.size.height - getYOffset
            frame.size.width            = frame.size.height / self.imageRatio
            frame.origin.x              = self.originFrame.origin.x - (frame.size.width - self.originFrame.size.width) * 0.5
            self.stretchedView.frame    = frame
        }
    }
    
}
