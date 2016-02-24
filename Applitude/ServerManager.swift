//
//  ServerManager.swift
//  Applitude
//
//  Created by Gaute Solheim on 12.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//
//  Handles all communication with dagens-backend (effectively Amazon S3), and saves the received data locally.
//

import Foundation

class ServerManager: NSObject {
    
    // Singleton: Available globally, max. one instance
    static let sharedInstance = ServerManager()
    private override init() {}
    
    private var timestamp: Int = 0
    private var restaurants = [Restaurant]()
    private var dishes = [Dish]()
    
    // SECTION: Methods
    
    func getNumberOfDishes() -> Int {
        return dishes.count
    }
    
    func getDishAtIndex(index: Int) -> Dish {
        return dishes[index]
    }
    
    func requestDishes() {
        
        // TODO: Request dishes from S3
        
        // MARK: Temporary sample data
        
        restaurants = [
            Restaurant(title: "Andrea spiseri", street: "Pilestredet 32", postalCode: "0166", city: "Oslo"),
            Restaurant(title: "Informatikkafeen", street: "Gaustadalleen 23 C", postalCode: "0373", city: "Oslo"),
            Restaurant(title: "Helga spiseri", street: "Sem Sælands vei 7", postalCode: "0371", city: "Oslo")
        ]
        
        for restaurant in restaurants {
            dishes.append(Dish(title: "Pulled Pork Burrito med krydret ris og bønner", price: "13,- pr. hg.", veggie: false, allergies: ["NA"], restaurant: restaurant))
            dishes.append(Dish(title: "Enchilada de Pollo med salsa verde og salatbar", price: "13,- pr. hg.", veggie: false, allergies: ["Melk, nøtter"], restaurant: restaurant))
            dishes.append(Dish(title: "Buffet med nystekt kylling, sei arrabiata og ovnsbakte amadinepoteter", price: "13,- pr. hg.", veggie: false, allergies: ["Egg"], restaurant: restaurant))
            dishes.append(Dish(title: "Enchilada de Frijoles med salsa verde og salatbar.", price: "13,- pr. hg.", veggie: true, allergies: [], restaurant: restaurant))
        }
        
    }
    
}
