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
    private let detail: String?
    private var allergies: [String]?
    private let price: String
    private let veggie: Bool
    
    init(title: String, detail: String?, allergies: [String], price: String, veggie: Bool) {
        self.title = title
        self.detail = detail
        self.price = price
        self.veggie = veggie
        
        if allergies.count != 0 {
            self.allergies = allergies
        }
        
        super.init()
    }
    
    
    
}