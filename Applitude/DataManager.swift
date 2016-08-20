import Foundation
import CoreLocation

class DataManager: NSObject {
    
    // Singleton: Available globally, max. one instance
    static let sharedInstance = DataManager()
    private override init() {}
    
    private let httpController = HTTPController()
    private let locationManager = CLLocationManager()
    
    var restaurants: [Restaurant] {
        get {
            return storedRestaurants
        }
        set(newValue) {
            let filteredRestaurants = newValue.filter { $0.dishes?.count > 0 }
            let sortedRestaurants = sortRestaurantsArrayByUserLocation(filteredRestaurants)
            storedRestaurants = sortedRestaurants
        }
    }

    private var userLocation: CLLocation? {
        didSet {
            if userLocation != nil {
                let sortedRestaurants = sortRestaurantsArrayByUserLocation(storedRestaurants)
                storedRestaurants = sortedRestaurants
            }
        }
    }

    private var storedRestaurants = [Restaurant]() {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName("DishesUpdated", object: nil)
        }
    }

    // How long time before midnight should we begin displaying tomorrow's dishes?
    let displaysTodaysDishesOffset: NSTimeInterval = 60 * 60 * 5

    var displaysTodaysDishes: Bool {
        return NSCalendar.currentCalendar().isDateInToday(NSDate().dateByAddingTimeInterval(displaysTodaysDishesOffset))
    }

    func prepareForInactiveState() {
        userLocation = nil // Prevents unnecessary sorting with an outdated location
    }

    // MARK: RESTController
    
    func fetchTodaysDinner() {
        httpController.requestDishes()
    }

    // MARK: Location services

    func setupLocationUpdates() {
        guard CLLocationManager.authorizationStatus() != .Denied else {
            return
        }

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func sortRestaurantsArrayByUserLocation(restaurantsArray: [Restaurant]) -> [Restaurant] {
        guard let userLocation = userLocation where !restaurantsArray.isEmpty else {
            return restaurantsArray
        }

        var restaurantsArray = restaurantsArray

        restaurantsArray.forEach { restaurant in
            let restaurantLocation = CLLocation(latitude: restaurant.coordinates.lat, longitude: restaurant.coordinates.long)
            let distanceFromUser = userLocation.distanceFromLocation(restaurantLocation)

            restaurant.distanceFromUser = distanceFromUser
        }

        restaurantsArray.sortInPlace { $0.distanceFromUser < $1.distanceFromUser }

        print("restaurants-array-sorted")

        return restaurantsArray
    }

}

// MARK: - CLLocationManagerDelegate

extension DataManager: CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location-manager-did-update-locations")

        userLocation = locations.first
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location-manager-did-fail-with-error")
        print(error)
    }

}

