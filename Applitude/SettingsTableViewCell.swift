//
//  SettingsTableViewCell.swift
//  Applitude
//
//  Created by Anders Orset on 19.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsLabel: UILabel!    
    @IBOutlet weak var settingsSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(setting: (title: String, value: Bool)) {
        settingsLabel.text = setting.title
        settingsSwitch.enabled = setting.value
    }

}
