//
//  Restaurant.swift
//  Applitude
//
//  Created by Gaute Solheim on 19.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit

class Restaurant: NSObject {
    
    // TODO: Opening hours
    
    private let title: String
    private let address: String
    private let campus: String
    private let coordinates: (lat: Double, long: Double)
    
    init(title: String, address: String, campus: String, coordinates: (lat: Double, long: Double)) {
        self.title = title
        self.address = address
        self.campus = campus
        self.coordinates = coordinates
        
        super.init()
    }
    
    /*func getTitle() -> String {
        return title
    }
    
    func getStreet() -> String {
        return street
    }
    
    func getPostalCode() -> String {
        return postalCode
    }
    
    func getCity() -> String {
        return city
    }*/

}
