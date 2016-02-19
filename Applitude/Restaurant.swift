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
    private let street: String
    private let postalCode: String
    private let city: String
    
    init(title: String, street: String, postalCode: String, city: String) {
        self.title = title
        self.street = street
        self.postalCode = postalCode
        self.city = city
        
        super.init()
    }
    
    func getTitle() -> String {
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
    }

}
