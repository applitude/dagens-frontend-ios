import Foundation

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
    
}
