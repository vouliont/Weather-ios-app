import Foundation
import RxSwift

class WeatherOfCityViewModel {
    private let temperatureSubject = BehaviorSubject<Int>(value: 0)
    
    let temperature: Observable<Int>
    
    init() {
        temperature = temperatureSubject.asObservable()
    }
}
