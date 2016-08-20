import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet var settingsLabel: UILabel!
    @IBOutlet var settingsSwitch: UISwitch!
    
    func loadCellForRow(row: Int, isOn: Bool, title: String) {
        settingsSwitch.tag = row
        settingsSwitch.on = isOn

        settingsLabel.text = title
    }

}
