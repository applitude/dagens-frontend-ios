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
    @IBOutlet var circleImageView: UIImageView!
    
    @IBOutlet var firstAllergyImageView: UIImageView!
    @IBOutlet var secondAllergyImageView: UIImageView!
    @IBOutlet var thirdAllergyImageView: UIImageView!
    @IBOutlet var plusAllergyImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.setColors()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(dish: Dish) {
        //titleLabel.text = dish.getTitle()
        //allergiesLabel.text = dish.getAllergiesString()
        
        setColors()
    }
    
    func setColors() {
        let color = Settings.sharedInstance.themeColor
        
        restaurantLabel.textColor = color
        distanceLabel.textColor = color
        // circleImageView change image
    }
    
}
