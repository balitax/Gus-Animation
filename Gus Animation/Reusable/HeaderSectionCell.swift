//
//  HeaderSectionCell.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 12/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit

class HeaderSectionCell: UITableViewCell {
    
    @IBOutlet weak var titleSection: UILabel!
    @IBOutlet weak var borderSection: GSViewDashLine!
    
    
    static func create() -> UINib {
        return UINib(nibName: "HeaderSectionCell", bundle: Bundle.main)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
