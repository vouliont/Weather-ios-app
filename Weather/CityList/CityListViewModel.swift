import Foundation
import RxSwift

class CityListViewModel {
    enum Segues: String {
        case addCity = "addCitySegue"
    }
    
    private let cityManager = CityManager()
    
    // MARK: output
    let oCities: Observable<[City]>
    
    init() {
        let cities = cityManager.getCities()
        let sCities = BehaviorSubject<[City]>(value: cities)
        oCities = sCities.asObservable()
    }
}
