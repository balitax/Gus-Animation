//
//  HomeViewCell.swift
//  Gus Animation
//
//  Created by Agus Cahyono on 11/11/18.
//  Copyright © 2018 Agus Cahyono. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    @IBOutlet weak var imgFood: GSImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodDesc: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var addButton: GSButton!
    @IBOutlet weak var likeButton: WCLShineButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func buildMenu() {
        
        var param2 = WCLShineParams()
        param2.bigShineColor = UIColor(hexString: "E72C31")
        param2.smallShineColor = UIColor(hexString: "E72C31")
        param2.shineCount = 15
        param2.animDuration = 3
        param2.smallShineOffsetAngle = -5
        likeButton.params = param2
        likeButton.image = .heart
        
    }

}
