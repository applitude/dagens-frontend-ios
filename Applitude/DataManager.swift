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
            storedRestaurants = newValue
            filterStoredRestaurants()
            NSNotificationCenter.defaultCenter().postNotificationName("dishesUpdated", object: nil)
        }
    }

    private var storedRestaurants = [Restaurant]()

    // MARK: RESTController
    
    func fetchTodaysDinner() {
        httpController.requestDishes()
    }

    // MARK: Location services

    func setupLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func filterStoredRestaurants() {
        storedRestaurants = storedRestaurants.filter { $0.dishes?.count > 0 }
    }

}

// MARK: - CLLocationManagerDelegate

extension DataManager: CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location-manager-did-update-locations")

        guard locations.count > 0 else {
            return
        }

        sortRestaurantsForUserLocation(locations[0])
    }

    private func sortRestaurantsForUserLocation(userLocation: CLLocation) {

        storedRestaurants.forEach { restaurant in
            let restaurantLocation = CLLocation(latitude: restaurant.coordinates.lat, longitude: restaurant.coordinates.long)
            let distanceFromUser = userLocation.distanceFromLocation(restaurantLocation)

            restaurant.distanceFromUser = distanceFromUser
        }

        restaurants = storedRestaurants.sort { $0.distanceFromUser <= $1.distanceFromUser }
    }

}

