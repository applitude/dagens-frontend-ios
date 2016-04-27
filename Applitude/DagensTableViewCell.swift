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

class DagensTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var restaurantLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var circleImageView: UIImageView!
    
    @IBOutlet var firstAllergyImageView: UIImageView!
    @IBOutlet var secondAllergyImageView: UIImageView!
    @IBOutlet var thirdAllergyImageView: UIImageView!
    @IBOutlet var plusAllergyImageView: UIImageView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    func loadMap(coordinates: (lat: Double, long: Double)) {
        mapView.myLocationEnabled = true
        mapView.animateToLocation(CLLocationCoordinate2DMake(coordinates.lat, coordinates.long))
        mapView.animateToZoom(15)
        mapView.myLocation
    }
    
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
        titleLabel.text = dish.getTitle()
        restaurantLabel.text = dish.getRestaurant().getTitle()
        
        loadMap(dish.getRestaurant().getCoordinates())
        
        // HACK: Should be stored in array as instance variable
        var imageViewOutlets = [UIImageView]()
        imageViewOutlets.append(firstAllergyImageView)
        imageViewOutlets.append(secondAllergyImageView)
        imageViewOutlets.append(thirdAllergyImageView)
        imageViewOutlets.append(plusAllergyImageView)
        
        // Avoids persistence of images on reload - unknown reason
        for item in imageViewOutlets {
            item.image = nil
        }
        
        var outletIndex = 0
        for allergy in dish.getAllergies() {
            if let image = getImageForAllergy(allergy) {
                imageViewOutlets[outletIndex].image = image
                outletIndex += 1
            }
        }
        
        setColors()
    }
    
    func setColors() {
        let color = Settings.sharedInstance.themeColor
        
        restaurantLabel.textColor = color
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
