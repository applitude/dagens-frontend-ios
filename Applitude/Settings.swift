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
    }
    
    private var settings: [Bool] = [
        
        NSUserDefaults.standardUserDefaults().boolForKey(SettingsKeys.veggie),
        
        
    ]
    
}
