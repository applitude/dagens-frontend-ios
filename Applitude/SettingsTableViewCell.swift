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
    
    func loadCellForRow(row: Int, isOn: Bool, setting: SettingsKey) {
        settingsSwitch.tag = row
        settingsSwitch.on = isOn

        settingsLabel.text = setting.rawValue
    }

}
