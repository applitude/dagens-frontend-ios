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
            let displaysTodaysDishes = DataManager.sharedInstance.displaysTodaysDishes
            
            for (dateString, dateJSON): (String, JSON) in dayArray {

                guard let date = parseDateString(dateString) else {
                    // TODO: Report error or return nil
                    return
                }

                guard displaysTodaysDishes && NSCalendar.currentCalendar().isDateInToday(date) || !displaysTodaysDishes && NSCalendar.currentCalendar().isDateInTomorrow(date) else {
                    continue
                }

                let priceJSON = dateJSON.filter { _, dishOrPriceJSON in dishOrPriceJSON["type"] == "Pris" }.first?.1
                let price = priceJSON?["name"].stringValue

                let dishJSONs = dateJSON.filter { _, dishOrPriceJSON in dishOrPriceJSON["type"] != "Pris" }
                dishJSONs.forEach { _, dishJSON in
                    let dish = parseDishJSON(dishJSON, price: price)
                    dishes.append(dish)
                }

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

    private func parseDateString(dateString: String) -> NSDate? {

        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone(abbreviation: "CET")

        let date = formatter.dateFromString(dateString)

        return date
    }

    private func parseDishJSON(dishJSON: JSON, price: String?) -> Dish {

        var title = dishJSON["name"].stringValue
        let veggie = dishJSON["type"].stringValue == "Vegetar"

        // Extract allergies from dish's title
        var suffix = ""
        var allergies = [String]()

        if let rangeOfKeyword = title.rangeOfString("Allergener:", options: [.BackwardsSearch, .CaseInsensitiveSearch]) {
            suffix = String(title.characters.suffixFrom(rangeOfKeyword.endIndex))
            allergies = suffix.componentsSeparatedByString(", ")
            title = String(title.characters.prefixUpTo(rangeOfKeyword.startIndex))

            if allergies[0].characters.first == " " {
                allergies[0] = String(allergies[0].characters.dropFirst())
            }
        }

        // Uncomment if the noLactose and/or noGluten tags are put to use
//        if /* title is not marked with \"Allergener: se merking\" */ {
//            if !dishOrPriceInfo["noLactose"].boolValue {
//                allergies.append("laktose")
//            }
//
//            if !dishOrPriceInfo["noGluten"].boolValue {
//                allergies.append("gluten")
//            }
//        }

        let dish = Dish(title: title, price: price, veggie: veggie, allergies: allergies)

        return dish
    }

}
