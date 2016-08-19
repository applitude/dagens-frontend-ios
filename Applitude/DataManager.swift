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
            guard userLocation != nil || CLLocationManager.authorizationStatus() == .Denied else {
                return
            }

            storedRestaurants = newValue.filter { $0.dishes?.count > 0 }
            sortRestaurantsForUserLocation()
            NSNotificationCenter.defaultCenter().postNotificationName("dishesUpdated", object: nil)
        }
    }

    private var storedRestaurants = [Restaurant]()
    private var userLocation: CLLocation?

    // MARK: RESTController
    
    func fetchTodaysDinner() {
        httpController.requestDishes()
    }

    // MARK: Location services

    func setupLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func sortRestaurantsForUserLocation() {
        guard let userLocation = userLocation else {
            return
        }

        storedRestaurants.forEach { restaurant in
            let restaurantLocation = CLLocation(latitude: restaurant.coordinates.lat, longitude: restaurant.coordinates.long)
            let distanceFromUser = userLocation.distanceFromLocation(restaurantLocation)

            restaurant.distanceFromUser = distanceFromUser
        }

        storedRestaurants.sortInPlace { $0.distanceFromUser < $1.distanceFromUser }
    }

}

// MARK: - CLLocationManagerDelegate

extension DataManager: CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location-manager-did-update-locations")

        userLocation = locations.first
    }

}

