import Foundation
import RxSwift
import CoreLocation

class AddCityViewModel {
    // MARK: input
    let iCoordinate: AnyObserver<CLLocationCoordinate2D>
    
    // MARK: output
    let oCoordinate: Observable<CLLocationCoordinate2D>
    
    init() {
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0) // todo: change coordinate to normal
        let sCoordinate = BehaviorSubject<CLLocationCoordinate2D>(value: coordinate)
        iCoordinate = sCoordinate.asObserver()
        oCoordinate = sCoordinate.asObservable()
        
        
    }
}
