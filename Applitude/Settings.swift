//
//  Settings.swift
//  Applitude
//
//  Created by Gaute Solheim on 12.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import UIKit

class Settings: NSObject {
    
    // Singleton: Available globally, max. one instance
    static let sharedInstance = Settings()
    private override init() {}
    
    private struct SettingsKeys {
        static let veggie = "veggie"
        static let gluten = "gluten"
    }
    
    var themeColor = UIColor(red: 251/255.0, green: 84/255.0, blue: 110/255.0, alpha: 1)
    
    private var settings: [(title: String, value: Bool)] = [
        
        (SettingsKeys.veggie, NSUserDefaults.standardUserDefaults().boolForKey(SettingsKeys.veggie)),
        (SettingsKeys.gluten, NSUserDefaults.standardUserDefaults().boolForKey(SettingsKeys.gluten))
        
    ]
   
    func getSettingAtIndex(index:Int) -> (title: String, value: Bool) {
        return settings[index]
    }
    
}
