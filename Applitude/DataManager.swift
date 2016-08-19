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
            storedRestaurants = newValue.filter { $0.dishes?.count > 0 }
            sortRestaurantsByUserLocation()
        }
    }

    private var userLocation: CLLocation? {
        didSet {
            sortRestaurantsByUserLocation()
        }
    }

    private var storedRestaurants = [Restaurant]()

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

    private func sortRestaurantsByUserLocation() {
        guard CLLocationManager.authorizationStatus() != .Denied else {
            NSNotificationCenter.defaultCenter().postNotificationName("dishesUpdated", object: nil)
            print("dishes-updated")
            return
        }

        guard let userLocation = userLocation where !storedRestaurants.isEmpty else {
            return
        }

        storedRestaurants.forEach { restaurant in
            let restaurantLocation = CLLocation(latitude: restaurant.coordinates.lat, longitude: restaurant.coordinates.long)
            let distanceFromUser = userLocation.distanceFromLocation(restaurantLocation)

            restaurant.distanceFromUser = distanceFromUser
        }

        storedRestaurants.sortInPlace { $0.distanceFromUser < $1.distanceFromUser }

        NSNotificationCenter.defaultCenter().postNotificationName("dishesUpdated", object: nil)
        print("dishes-updated")
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

