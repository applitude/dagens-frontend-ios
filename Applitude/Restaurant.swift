import UIKit

class Restaurant: NSObject {
    
    let title: String
    let address: String
    let campus: String
    let coordinates: (lat: Double, long: Double)
    let opening: [(dayRange: String, hours: String)]
    let extraOpening: String?
    var dishes: [Dish]?
    
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

}
