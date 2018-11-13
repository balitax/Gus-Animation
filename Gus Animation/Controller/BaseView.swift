//
//  BaseView.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 11/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit

class BaseView: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func transparentNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
}


class RemovablePanelLayout: FloatingPanelLayout {
    var initialPosition: FloatingPanelPosition {
        return .half
    }
    var supportedPositions: Set<FloatingPanelPosition> {
        return [.full, .half]
    }
    var bottomInteractionBuffer: CGFloat {
        return 261.0 - 22.0
    }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 16.0
        case .half: return 261.0
        default: return nil
        }
    }
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.3
    }
}

class RemovablePanelLandscapeLayout: FloatingPanelLayout {
    var initialPosition: FloatingPanelPosition {
        return .half
    }
    var supportedPositions: Set<FloatingPanelPosition> {
        return [.half]
    }
    var bottomInteractionBuffer: CGFloat {
        return 261.0 - 22.0
    }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .half: return nil
        default: return nil
        }
    }
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.3
    }
}
