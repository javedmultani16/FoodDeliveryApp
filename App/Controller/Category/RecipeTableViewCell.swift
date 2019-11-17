//
//  RecipeTableViewCell.swift
//  App
//
//  Created by Javed Multani on 16/11/2019.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewGallery: UIImageView!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewMain.layer.cornerRadius = 10.0
        self.viewMain.clipsToBounds = true
        
        self.imageViewGallery.layer.cornerRadius = 5.0
        self.imageViewGallery.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
