import UIKit

enum SettingsKey: String {
    case BlackTheme = "blackTheme"
    case Veggie = "veggie"
    case Gluten = "gluten"
}

class SettingsManager: NSObject {
    
    // Singleton: Available globally, max. one instance
    static let sharedInstance = SettingsManager()
    
    private(set) var themeColor: UIColor {
        didSet {
            switchThemeForRootViewController()
        }
    }
    
    // Array for loading table view cells - may be reordered or split.
    let settings: [(key: SettingsKey, title: String)] = [
        (.BlackTheme, "Dark Theme"),
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
        default: break
        }
    }

    func switchThemeForRootViewController() {
        if let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? UINavigationController {
            rootViewController.navigationBar.barTintColor = themeColor
        }
    }
    
}
