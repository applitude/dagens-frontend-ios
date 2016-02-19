//
//  Settings.swift
//  Applitude
//
//  Created by Gaute Solheim on 12.02.2016.
//  Copyright © 2016 Applitude. All rights reserved.
//

import Foundation

class Settings: NSObject {
    
    // Singleton: Available globally, max. one instance
    static let sharedInstance = Settings()
    private override init() {}
    
    private struct SettingsKeys {
        static let veggie = "veggie"
        static let gluten = "gluten"
    }
    
    private var settings: [(title: String, value: Bool)] = [
        
        (SettingsKeys.veggie, NSUserDefaults.standardUserDefaults().boolForKey(SettingsKeys.veggie)),
        (SettingsKeys.gluten, NSUserDefaults.standardUserDefaults().boolForKey(SettingsKeys.gluten))
        
    ]
   
    func getSettingAtIndex(index:Int) -> (title: String, value: Bool) {
        return settings[index]
    }
    
}
