import UIKit
import Alamofire
import SwiftyJSON

class HTTPController: NSObject {
    
    private let endpoint: URLStringConvertible = "https://s3-eu-west-1.amazonaws.com/todays-dinner/sioapi.json"


    func requestDishes() {
        // Change the cache policy so that no existing cache data should be used to satisfy a URL load request.
        let requestCachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
      
        Alamofire.Manager.sharedInstance.session.configuration.requestCachePolicy = requestCachePolicy
        
        // Sends the actual request, with a closure that gets executed when the data is received
        Alamofire.request(.GET, endpoint)
            .responseString { response in

                guard let dataFromString = response.result.value?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) else {
                    _ = response.result.error
                    
                    // TODO: Handle errors
                    
                    return
                }
                
                //print(JSON(data: dataFromString))
                self.parseJSON(JSON(data: dataFromString))
                
        }
        
    }

    private func parseJSON(json: JSON) {
        
        var restaurants = [Restaurant]()
        
        for (_, restaurantJSON): (String, JSON) in json["data"] {

            let restaurant = parseRestaurantJSON(restaurantJSON)

            // Convert JSON dictionary of day objects to array for sorting and iteration
            var dayArray = Array(restaurantJSON["resturants"].dictionaryValue)

            // Sort day array by date key (formatted as String), current day first
            dayArray.sortInPlace { $0.0 < $1.0 }
            
            var dishes = [Dish]()
            
            for (dateString, date): (String, JSON) in dayArray {
                
                // Temporary fix for app displaying yesterday's dishes before 13/14 o'clock
                let day = NSCalendar.currentCalendar().component(.Day, fromDate: NSDate())
                
                guard dateString.componentsSeparatedByString("-")[2].containsString(String(day)) else {
                    continue
                }
                
                // Find price info
                var price: String?
                
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
                    
                    let dish = parseDishJSON(dishOrPriceInfo, price: price)
                    
                    dishes.append(dish)
                    
                }
                
                // HACK: Stop after parsing first day (current day)
                break
                
            }
            
            restaurant.setDishes(dishes)

            restaurants.append(restaurant)
            
        }
        
        DataManager.sharedInstance.restaurants = restaurants
        
    }

    private func parseRestaurantJSON(restaurantJSON: JSON) -> Restaurant {

        let title = restaurantJSON["name"].stringValue
        let address = restaurantJSON["address"].stringValue
        let campus = restaurantJSON["campus"].stringValue
        let latitude = restaurantJSON["latitude"].doubleValue
        let longitude = restaurantJSON["longitude"].doubleValue

        var opening = [(dayRange: String, hours: String)]()

        for openingItem: JSON in restaurantJSON["opening"].arrayValue {
            let day = openingItem["day"].stringValue
            let hours = openingItem["value"].stringValue

            opening.append((day, hours))
        }

        var extraOpening: String? = nil

        for extraOpeningItem: JSON in restaurantJSON["extraopening"].arrayValue {
            let label = extraOpeningItem["label"].stringValue
            extraOpening = label
        }

        let restaurant = Restaurant(title: title, address: address, campus: campus, coordinates: (latitude, longitude), opening: opening, extraOpening: extraOpening)

        return restaurant
    }

    private func parseDishJSON(dishJSON: JSON, price: String?) -> Dish {

        var title = dishJSON["name"].stringValue
        let veggie = dishJSON["type"].stringValue == "Vegetar"

        // Extract allergies from dish's title
        var suffix = ""
        var allergies = [String]()

        if let rangeOfKeyword = title.rangeOfString("Allergener:", options: [NSStringCompareOptions.BackwardsSearch, NSStringCompareOptions.CaseInsensitiveSearch]) {
            suffix = String(title.characters.suffixFrom(rangeOfKeyword.endIndex))
            allergies = suffix.componentsSeparatedByString(", ")
            title = String(title.characters.prefixUpTo(rangeOfKeyword.startIndex))

            if allergies[0].characters.first == " " {
                allergies[0] = String(allergies[0].characters.dropFirst())
            }
        }

        // Uncomment if the noLactose and/or noGluten tags are put to use
        /*if /* title is not marked with \"Allergener: se merking\" */ {
         if !dishOrPriceInfo["noLactose"].boolValue {
         allergies.append("laktose")
         }

         if !dishOrPriceInfo["noGluten"].boolValue {
         allergies.append("gluten")
         }
         }*/

        // Uncomment for a rough test of allergies parsing
        // print("title: \(title), allergies-count: \(allergies.count)")

        let dish = Dish(title: title, price: price, veggie: veggie, allergies: allergies)

        return dish
    }

}
