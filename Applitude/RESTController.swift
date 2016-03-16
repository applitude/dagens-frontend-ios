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
    
    private let url: URLStringConvertible = "https://s3-eu-west-1.amazonaws.com/todays-dinner/sioapi.json"
    
    //private var restaurants = [Restaurant]()
    
    func requestDishes() {
        
        // Sends the actual request, with a closure that gets executed when the data is received
        Alamofire.request(.GET, url)
            .responseString { response in

                guard let dataFromString = response.result.value?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) else {
                    
                    let error = response.result.error
                    
                    // TODO: Behandle feil
                    return
                }
                
                let json = JSON(data: dataFromString)
                print(json)
                
                self.parseJSON(json)
                
        }
        
        // MARK: Temporary sample data
        
        /*restaurants = [
            Restaurant(title: "Andrea spiseri", street: "Pilestredet 32", postalCode: "0166", city: "Oslo"),
            Restaurant(title: "Informatikkafeen", street: "Gaustadalleen 23 C", postalCode: "0373", city: "Oslo"),
            Restaurant(title: "Helga spiseri", street: "Sem Sælands vei 7", postalCode: "0371", city: "Oslo")
        ]
        
        for restaurant in restaurants {
            dishes.append(Dish(title: "Pulled Pork Burrito med krydret ris og bønner", price: "13,- pr. hg.", veggie: false, allergies: ["NA"], restaurant: restaurant))
            dishes.append(Dish(title: "Enchilada de Pollo med salsa verde og salatbar", price: "13,- pr. hg.", veggie: false, allergies: ["Melk, nøtter"], restaurant: restaurant))
            dishes.append(Dish(title: "Buffet med nystekt kylling, sei arrabiata og ovnsbakte amadinepoteter", price: "13,- pr. hg.", veggie: false, allergies: ["Egg"], restaurant: restaurant))
            dishes.append(Dish(title: "Enchilada de Frijoles med salsa verde og salatbar.", price: "13,- pr. hg.", veggie: true, allergies: [], restaurant: restaurant))
        }*/
        
    }
    
/*
address": "Pilestredet 32, 0166 Oslo",
  "week": 11,
"campus": "HiOA Bislett",
"latitude": 59.91996,
"description": "I Andreas spiseri kan du forsyne deg med varmmat, suppe, salat, pålegg og brød fra vår buffet, - og betale på vekt. I tillegg finner du et bredt utvalg av wraps, smurte produkter og fristende kaker og bakevarer. Alt servert i store, lyse og moderne lokaler. Kåret til HiOAs beste spisested av khrono.no i 2014.",
    "house": "Andrea Arntzens Hus",
"opening": [
{
    "day": "Mandag - fredag",
    "value": "09.00 - 15.30"
}
],
"resturants": {
"2016-03-16": [
{
    "name": "Little Seafood Saturday: English Fish Pie med råkost. Allergener: se merking i kafeen.",
    "type": "Dagens",
    "noGluten": false,
    "noLactose": false
},
{
    "name": "Cacio e Pepe med stek grønn paprika. Allergener: se merking i kafeen.",
    "type": "Vegetar",
    "noGluten": false,
    "noLactose": false
},
{
    "name": "Løsvekt kr 13,- pr. hg.",
    "type": "Pris",
    "noGluten": false,
    "noLactose": false
}
],*/

    func parseJSON(json: JSON) {
        
        let data = json["data"]
        
        for (_, restaurantDict) : (String, JSON) in data {
            
            let title = restaurantDict["name"].stringValue
            let address = restaurantDict["address"].stringValue
            let campus = restaurantDict["campus"].stringValue
            let latitude = restaurantDict["latitude"].doubleValue
            let longitude = restaurantDict["longitude"].doubleValue
            let opening = restaurantDict["opening"].arrayValue
            let extraOpening = restaurantDict["extraopening"].arrayValue
            
            let restaurant = Restaurant(title: title, address: address, campus: campus, coordinates: (latitude, longitude))
            
            let dishData = restaurantDict["resturants"].dictionaryValue
            //print(dishData)
            
            var dishArray = [(String, JSON)]()
            
            // #warning: Insane hack
            for item in dishData {
                dishArray.append(item)
            }
            
            dishArray.sortInPlace { $0.0 < $1.0 }
            //print("---")
            print(dishArray)
            
            for (index, dateDict) : (String, JSON) in dishData {
                
                let dishDict = dateDict.dictionaryValue
                
            }
            
        }
        
    }

}
