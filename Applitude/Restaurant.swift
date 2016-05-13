//
//  Restaurant.swift
//  Applitude
//
//  Created by Gaute Solheim on 19.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit

class Restaurant: NSObject {
    
    private let title: String
    private let address: String
    private let campus: String
    private let coordinates: (lat: Double, long: Double)
    private let opening: [(dayRange: String, hours: String)]
    private let extraOpening: String?
    private var dishes: [Dish]? = nil
    
    init(title: String, address: String, campus: String, coordinates: (lat: Double, long: Double), opening: [(dayRange: String, hours: String)], extraOpening: String?) {
        self.title = title
        self.address = address
        self.campus = campus
        self.coordinates = coordinates
        self.opening = opening
        self.extraOpening = extraOpening
        
        super.init()
    }
    
    func setDishes(dishes: [Dish]) {
        self.dishes = dishes
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getAddress() -> String {
        return address
    }
    
    func getCampus() -> String {
        return campus
    }
    
    func getCoordinates() -> (lat: Double, long: Double) {
        return coordinates
    }
    
    func getOpening() -> [(dayRange: String, hours: String)] {
        return opening
    }
    
    func getExtraOpening() -> String? {
        return extraOpening
    }
    
    func getDishes() -> [Dish]? {
        return dishes
    }

}
