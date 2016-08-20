import UIKit

class DagensTableViewController: UITableViewController {

    private var headerView: DagensDateTableViewHeader?
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register to receive notifications that we'll post when the dishes collection is updated
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DagensTableViewController.reloadData), name: "DishesUpdated", object: nil)

        headerView = NSBundle.mainBundle().loadNibNamed("DagensDateTableViewHeader", owner: self, options: nil).first as? DagensDateTableViewHeader
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        headerView?.frame.size.height = 60
        tableView.tableHeaderView = headerView
    }

    @objc private func reloadData() {
        tableView.reloadData()

        var title = "Viser menyen for i "
        title += DataManager.sharedInstance.displaysTodaysDishes ? "dag." : "morgen."
        headerView?.titleLabel.text = title
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
        let restaurant = DataManager.sharedInstance.restaurants[indexPath.section]

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as! DagensRestaurantTableViewCell

            let title = restaurant.title
            var opening = ""
            restaurant.opening.forEach { opening += "\($0.0) \($0.1), " }
            opening = String(opening.characters.dropLast(2))
            let rawDistance = restaurant.distanceFromUser

            let distance = formatDistanceForPresentation(rawDistance)

            cell.loadCell(title, opening: opening, distance: distance)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("DishCell", forIndexPath: indexPath) as! DagensDishTableViewCell

            let dish = restaurant.dishes![indexPath.row - 1]

            cell.loadCell(dish)
            return cell
        }
    }

    // TODO: Remove duplicate code, test
    func formatDistanceForPresentation(distance: Double?) -> String {
        guard let distance = distance else {
            return "? km"
        }

        let distanceString = String(Int(distance))

        let formattedDistance: String
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
        default:
            formattedDistance = ""
        }

        return formattedDistance
    }

}
