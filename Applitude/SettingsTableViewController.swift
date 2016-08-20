import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBAction func cellSwitchValueChanged(sender: UISwitch) {
        Settings.sharedInstance.changeValueForSettingAtIndex(sender.tag, value: sender.on)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Settings.sharedInstance.settings.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath) as! SettingsTableViewCell

        let setting = Settings.sharedInstance.settings[indexPath.row]
        let isOn = NSUserDefaults.standardUserDefaults().boolForKey(setting.key.rawValue)
        let title = setting.title

        cell.loadCellForRow(indexPath.row, isOn: isOn, title: title)

        return cell
    }

}
