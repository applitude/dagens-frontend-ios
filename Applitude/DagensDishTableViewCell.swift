//
//  DagensDishTableViewCell.swift
//  Applitude
//
//  Created by Gaute Solheim on 13.05.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit

class DagensDishTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var allergiesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(dish: Dish) {
        titleLabel.text = dish.getTitle()
        allergiesLabel.text = dish.getAllergiesString()
        
        print("--")
        print(self.frame.size.width)
        print(titleLabel.frame.size.width)
        
        titleLabel.numberOfLines = titleLabel.frame.width > self.frame.size.width - 200 ? 2 : 1
        titleLabel.preferredMaxLayoutWidth = self.frame.width - 100
        titleLabel.frame.size.height = 100
    }

}
