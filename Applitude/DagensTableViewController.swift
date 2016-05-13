//
//  DagensTableViewController.swift
//  Applitude
//
//  Created by Anders Orset on 12.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//
//  The app's main view.
//
//  Detailed explanation of the cell expansion/contraction: stackoverflow.com/a/29851944.
//

import UIKit

class DagensTableViewController: UITableViewController {
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Register to receive notifications that we'll post when the dishes collection is updated
        NSNotificationCenter.defaultCenter().addObserver(tableView, selector: #selector(UITableView.reloadData), name: "dishesUpdated", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return DataManager.sharedInstance.getNumberOfRestaurants()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dishes = DataManager.sharedInstance.getRestaurantAtIndex(section).getDishes() {
            return dishes.count + 1
        }
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("restaurantCell", forIndexPath: indexPath) as! DagensRestaurantTableViewCell
            cell.loadCell(DataManager.sharedInstance.getRestaurantAtIndex(indexPath.section))
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("dishCell", forIndexPath: indexPath) as! DagensDishTableViewCell
            let dish = DataManager.sharedInstance.getRestaurantAtIndex(indexPath.section).getDishes()![indexPath.row - 1]
            cell.loadCell(dish)
            return cell
        }
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
