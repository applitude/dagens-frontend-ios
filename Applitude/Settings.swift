import UIKit

enum SettingsKey: String {
    case BlackTheme = "blackTheme"
    case Veggie = "veggie"
    case Gluten = "gluten"
}

class Settings: NSObject {
    
    // Singleton: Available globally, max. one instance
    static let sharedInstance = Settings()
    
    var themeColor: UIColor
    
    // Array for loading table view cells - may be reordered or split.
    let settings: [(key: SettingsKey, title: String)] = [
        (.BlackTheme, "Black Theme Color"),
        (.Veggie, "Veggie"),
        (.Gluten, "Gluten")
    ]
    
    private let redColor = UIColor(red: 251/255.0, green: 84/255.0, blue: 110/255.0, alpha: 1)
    private let blackColor = UIColor.blackColor() // Temporary value, should be grey-ish
    
    private override init() {
        themeColor = NSUserDefaults.standardUserDefaults().boolForKey(SettingsKey.BlackTheme.rawValue) ? blackColor : redColor
    }
    
    func changeValueForSettingAtIndex(index: Int, value: Bool) {
        let setting = settings[index]

        NSUserDefaults.standardUserDefaults().setBool(value, forKey: setting.key.rawValue)
        
        // Handles immediate changes
        switch setting.key {
        case .BlackTheme:
            themeColor = value ? blackColor : redColor
            switchThemeColor(value)
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
