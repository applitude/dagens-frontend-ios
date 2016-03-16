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

class DataManager: NSObject {
    
    // Singleton: Available globally, max. one instance
    static let sharedInstance = DataManager()
    private override init() {}
    
    private var restController = RESTController()
    
    private var restaurants = [Restaurant]()
    private var dishes = [Dish]()
    
    // MARK: Getters
    
    func getNumberOfDishes() -> Int {
        return dishes.count
    }
    
    func getDishAtIndex(index: Int) -> Dish {
        return dishes[index]
    }

    // MARK: RESTController
    
    func fetchTodaysDinner() {
        restController.requestDishes()
        restaurants = restController.getRestaurants()
        dishes = restController.getDishes()
    }
    
}
