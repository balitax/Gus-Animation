//
//  HeaderSection.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 12/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit

class HeaderSection: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var sectionTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HeaderSection", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
