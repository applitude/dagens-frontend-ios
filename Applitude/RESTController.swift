//
//  RESTController.swift
//  Applitude
//
//  Created by Gaute Solheim on 16.03.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RESTController: NSObject {
    
    private let endpoint: URLStringConvertible = "https://s3-eu-west-1.amazonaws.com/todays-dinner/sioapi.json"
    
    func requestDishes() {
        
        // Sends the actual request, with a closure that gets executed when the data is received
        Alamofire.request(.GET, endpoint)
            .responseString { response in

                guard let dataFromString = response.result.value?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) else {
                    let _ = response.result.error
                    
                    // TODO: Handle errors
                    
                    return
                }
                
                //print(JSON(data: dataFromString))
                self.parseJSON(JSON(data: dataFromString))
                
        }
        
    }

    private func parseJSON(json: JSON) {
        
        var dishes = [Dish]()
        
        for (_, restaurantDict): (String, JSON) in json["data"] {
            
            let title = restaurantDict["name"].stringValue
            let address = restaurantDict["address"].stringValue
            let campus = restaurantDict["campus"].stringValue
            let latitude = restaurantDict["latitude"].doubleValue
            let longitude = restaurantDict["longitude"].doubleValue
            
            var opening = [(dayRange: String, hours: String)]()
            
            for openingItem: JSON in restaurantDict["opening"].arrayValue {
                let day = openingItem["day"].stringValue
                let hours = openingItem["value"].stringValue
                
                opening.append((day, hours))
            }
            
            var extraOpening: String? = nil
            
            for extraOpeningItem: JSON in restaurantDict["extraopening"].arrayValue {
                let label = extraOpeningItem["label"].stringValue
                extraOpening = label
            }
            
            let restaurant = Restaurant(title: title, address: address, campus: campus, coordinates: (latitude, longitude), opening: opening, extraOpening: extraOpening)
            
            // Convert JSON dictionary of day objects to array for sorting and iteration
            var dayArray = [(String, JSON)]()
            
            for day in restaurantDict["resturants"].dictionaryValue {
                dayArray.append(day)
            }
            
            // Sort day array by date key (formatted as String), current day first
            dayArray.sortInPlace { $0.0 < $1.0 }
            
            for (_, date): (String, JSON) in dayArray {
                
                // Find price info
                var price = "NA"
                
                for (_, dishOrPriceInfo): (String, JSON) in date {
                    
                    if dishOrPriceInfo["type"].stringValue == "Pris" {
                        price = dishOrPriceInfo["name"].stringValue
                        break
                    }
                    
                }
                
                // Add dishes
                for (_, dishOrPriceInfo): (String, JSON) in date {
                    
                    guard dishOrPriceInfo["type"].stringValue != "Pris" else {
                        continue
                    }
                    
                    let title = dishOrPriceInfo["name"].stringValue
                    //let lactoseFree = dish["noLactose"].boolValue
                    //let glutenFree = dish["noGluten"].boolValue
                    
                    // TODO: Get and format more values
                    
                    dishes.append(Dish(title: title, price: price, veggie: false, allergies: ["String"], restaurant: restaurant))
                    
                }
                
                // HACK: Stop after parsing first day (current day)
                break
                
            }
            
        }
        
        DataManager.sharedInstance.dishes = dishes
        
    }

}
