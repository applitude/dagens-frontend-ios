import Foundation

struct Dish {
    
    let title: String
    let price: String?
    let veggie: Bool
    let allergies: [String]

    var allergiesString: String? {
        guard allergies.count > 0 else {
            return nil
        }

        var allergiesString = "Allergener: "
        allergies.forEach { allergiesString += "\($0), " }
        allergiesString = String(allergiesString.characters.dropLast(2))

        return allergiesString
    }
    
}