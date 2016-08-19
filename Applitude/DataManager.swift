import Foundation
import CoreLocation

class DataManager: NSObject {
    
    // Singleton: Available globally, max. one instance
    static let sharedInstance = DataManager()
    private override init() {}
    
    private var httpController = HTTPController()
    
    var restaurants = [Restaurant]() {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName("dishesUpdated", object: nil)
        }
    }
    
    // MARK: Getters
    
    func getNumberOfRestaurants() -> Int {
        return restaurants.count
    }
    
    func getRestaurantAtIndex(index: Int) -> Restaurant {
        return restaurants[index]
    }

    // MARK: RESTController
    
    func fetchTodaysDinner() {
        httpController.requestDishes()
    }

    // MARK: Location

    func sortRestaurantsByDistance() {
        let userLocation = CLLocation(latitude: 59.94285718496329, longitude: 10.761729549961919)

        restaurants.forEach { restaurant in
            let restaurantLocation = CLLocation(latitude: restaurant.coordinates.lat, longitude: restaurant.coordinates.long)
            let distanceFromUser = userLocation.distanceFromLocation(restaurantLocation)

            restaurant.distanceFromUser = distanceFromUser
        }

        restaurants.sortInPlace { $0.distanceFromUser <= $1.distanceFromUser }
    }

}
