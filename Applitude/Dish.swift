//
//  Dish.swift
//  Applitude
//
//  Created by Pavel Shramau on 12/02/16.
//  Copyright © 2016 Applitude. All rights reserved.
//

import Foundation

class Dish: NSObject {
    
    private let title: String
    private let veggie: Bool
    private let price: String
    private let allergies: [String]?
    private let restaurant: Restaurant
    
    init(title: String, price: String, veggie: Bool, allergies: [String], restaurant: Restaurant) {
        self.title = title
        self.price = price
        self.veggie = veggie
        self.allergies = allergies.count != 0 ? allergies : nil
        self.restaurant = restaurant
        
        super.init()
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getPrice() -> String {
        return price
    }
    
    func getAllergies() -> [String]? {
        return allergies
    }
    
    func getRestaurant() -> Restaurant {
        return restaurant
    }
    
    func isVeggie() -> Bool {
        return veggie
    }
    
}