import UIKit

class CityCell: UITableViewCell {
    @IBOutlet var cityNameLabel: UILabel!
    
    static let identifier = "cityCell"

    func configure(city: City) {
        cityNameLabel.text = city.name
    }

}
