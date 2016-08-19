import UIKit

class DagensTableViewController: UITableViewController {
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Register to receive notifications that we'll post when the dishes collection is updated
        NSNotificationCenter.defaultCenter().addObserver(tableView, selector: #selector(UITableView.reloadData), name: "dishesUpdated", object: nil)

        DataManager.sharedInstance.setupLocationServices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return DataManager.sharedInstance.restaurants.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dishes = DataManager.sharedInstance.restaurants[section].dishes {
            return dishes.count + 1
        }
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("restaurantCell", forIndexPath: indexPath) as! DagensRestaurantTableViewCell

            let restaurant = DataManager.sharedInstance.restaurants[indexPath.section]

            let title = restaurant.title
            let opening = "09.00 - 17.00" // TODO
            let rawDistance = restaurant.distanceFromUser ?? -1

            let distance = formatDistanceForPresentation(rawDistance)

            cell.loadCell(title, opening: opening, distance: distance ?? "")

            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("dishCell", forIndexPath: indexPath) as! DagensDishTableViewCell
            let dish = DataManager.sharedInstance.restaurants[indexPath.section].dishes![indexPath.row - 1]
            cell.loadCell(dish)
            return cell
        }
    }

    // TODO: Remove duplicate code, test
    func formatDistanceForPresentation(distance: Double) -> String? {
        let distanceString = String(Int(distance))

        var formattedDistance: String?
        switch distanceString.characters.count {
        case 1...2:
            let meters = String(Int(distance))
            formattedDistance = "\(meters) m"
        case 3...4:
            let kiloMeters = round(distance / 100) / 10
            let kiloMetersShortened = String(kiloMeters).substringWithRange(String(kiloMeters).characters.startIndex ..< String(kiloMeters).characters.startIndex.advancedBy(3)).stringByReplacingOccurrencesOfString(".", withString: ",")
            formattedDistance = "\(kiloMetersShortened) km"
        case 5:
            let kiloMeters = round(distance / 100) / 10
            let kiloMetersShortened = String(kiloMeters).substringWithRange(String(kiloMeters).characters.startIndex ..< String(kiloMeters).characters.startIndex.advancedBy(2)).stringByReplacingOccurrencesOfString(".", withString: ",")
            formattedDistance = "\(kiloMetersShortened) km"
        default: break
        }

        return formattedDistance
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
