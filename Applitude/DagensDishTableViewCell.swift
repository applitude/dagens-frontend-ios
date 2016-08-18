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
        titleLabel.text = dish.title
        allergiesLabel.text = dish.allergiesString
    }

}
