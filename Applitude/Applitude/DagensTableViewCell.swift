//
//  DagensTableViewCell.swift
//  Applitude
//
//  Created by Anders Orset on 12.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit

class DagensTableViewCell: UITableViewCell {

    //MARK: Properties
    var navn = "Hamburgertallerken"
    var allergener =  ["hvete", "sennep", "egg", "sesamfrø"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: Actions
    
}
