import UIKit
import RxSwift

class WeatherOfCityViewController: UIViewController {
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    let viewModel = WeatherOfCityViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindObservers()
    }
    
    private func bindObservers() {
        viewModel.temperature
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { temperature in
                self.temperatureLabel.text = String(temperature)
            })
            .disposed(by: disposeBag)
    }
}
