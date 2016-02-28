//
//  DagensTableViewCell.swift
//  Applitude
//
//  Created by Anders Orset on 12.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit

class DagensTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var restaurantLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
    @IBOutlet var firstAllergyImageView: UIImageView!
    @IBOutlet var secondAllergyImageView: UIImageView!
    @IBOutlet var thirdAllergyImageView: UIImageView!
    @IBOutlet var plusAllergyImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setColors(Settings.sharedInstance.themeColor)
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(dish: Dish) {
        //titleLabel.text = dish.getTitle()
        //allergiesLabel.text = dish.getAllergiesString()
    }
    
    func setColors(color: UIColor) {
        restaurantLabel.textColor = color
        
    }
    
}
