//
//  SettingsTableViewCell.swift
//  Applitude
//
//  Created by Anders Orset on 19.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet var settingsLabel: UILabel!
    @IBOutlet var settingsSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(row: Int) {
        let setting = Settings.sharedInstance.getSettingAtIndex(row)
        
        settingsLabel.text = setting
        settingsSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey(setting)
        settingsSwitch.tag = row
    }

}
