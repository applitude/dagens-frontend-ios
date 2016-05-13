//
//  DagensTableViewCell.swift
//  Applitude
//
//  Created by Anders Orset on 12.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit
import GoogleMaps

struct AllergyIcons {
    static var eggs = UIImage(named: "eggs")!
    static var milk = UIImage(named: "milk")!
    static var nuts = UIImage(named: "nuts")!
    static var soy = UIImage(named: "soy")!
    static var wheat = UIImage(named: "wheat")!
    static var unknown = UIImage(named: "dagens-cell-circle")
}

class DagensRestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var openingLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
    /*func loadMap(coordinates: (lat: Double, long: Double)) {
        mapView.myLocationEnabled = true
        mapView.animateToLocation(CLLocationCoordinate2DMake(coordinates.lat, coordinates.long))
        mapView.animateToZoom(15)
        mapView.myLocation
    }*/
    
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
        titleLabel.text = restaurant.getTitle()
        
        setColors()
    }
    
    func setColors() {
        let color = Settings.sharedInstance.themeColor
        
        titleLabel.textColor = color
        distanceLabel.textColor = color
        // circleImageView change image
    }
    
    private func getImageForAllergy(allergy: String) -> UIImage? {
        switch allergy {
            case "egg":
            return AllergyIcons.eggs
            case "melk":
            return AllergyIcons.milk
            case "nøtter":
            return AllergyIcons.nuts
            case "soya":
            return AllergyIcons.soy
            case "hvete":
            return AllergyIcons.wheat
        default:
            return allergy.containsString("se merking") ? AllergyIcons.unknown : nil
        }
    }
    
}
