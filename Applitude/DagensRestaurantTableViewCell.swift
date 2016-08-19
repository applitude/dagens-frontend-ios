//
//  DagensTableViewCell.swift
//  Applitude
//
//  Created by Anders Orset on 12.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit
import GoogleMaps

class DagensRestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var openingLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
    func loadCell(title: String, opening: String, distance: String) {
        titleLabel.text = title
        distanceLabel.text = distance
        
        setColors()
    }
    
    func setColors() {
        let color = Settings.sharedInstance.themeColor
        
        titleLabel.textColor = color
        distanceLabel.textColor = color
        // TODO: circleImageView change image
    }

}
