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
    
//    func loadMap(coordinates: (lat: Double, long: Double)) {
//        mapView.myLocationEnabled = true
//        mapView.animateToLocation(CLLocationCoordinate2DMake(coordinates.lat, coordinates.long))
//        mapView.animateToZoom(15)
//        mapView.myLocation
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.setColors()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(restaurant: Restaurant) {
        titleLabel.text = restaurant.title
        
        setColors()
    }
    
    func setColors() {
        let color = Settings.sharedInstance.themeColor
        
        titleLabel.textColor = color
        distanceLabel.textColor = color
        // TODO: circleImageView change image
    }

}
