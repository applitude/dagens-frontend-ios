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
    
    var themeColor: UIColor
    
    // The only structure containing the settings keys - should not be reordered.
    private struct SettingsKeys {
        static let blackTheme = "blackTheme"
        static let veggie = "veggie"
        static let gluten = "gluten"
    }
    
    // Array for loading table view cells - may be reordered or split.
    private var settings: [String] = [
        
        SettingsKeys.blackTheme,
        SettingsKeys.veggie,
        SettingsKeys.gluten
        
    ]
    
    private let redColor = UIColor(red: 251/255.0, green: 84/255.0, blue: 110/255.0, alpha: 1)
    private let blackColor = UIColor.blackColor() // Temporary value, should be grey-ish
    
    private override init() {
        themeColor = (NSUserDefaults.standardUserDefaults().boolForKey(SettingsKeys.blackTheme)) ? blackColor : redColor
    }
   
    func getSettingAtIndex(index:Int) -> String {
        return settings[index]
    }
    
    func getNumberOfSettings() -> Int {
        return settings.count
    }
    
    func setSettingAtIndex(index: Int, value: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: settings[index])
        
        // Handles immediate changes
        switch settings[index] {
            
        case SettingsKeys.blackTheme:
            themeColor = value ? blackColor : redColor
            switchThemeColor(value)
            
        case "noe":
            print("noe")
            
        default: break
            
        }
    }
    
    func switchThemeColor(black: Bool) {
        print("switch-theme-color")
        if let rootViewController = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController as? UINavigationController {
            rootViewController.navigationBar.barTintColor = themeColor
            print("theme-color-set")
        } else {
            print("switch-theme-color-failed")
        }
    }
    
}
