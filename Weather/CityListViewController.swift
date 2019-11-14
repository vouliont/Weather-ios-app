import UIKit
import RxSwift
import RxCocoa
import RxGesture

class CityListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bottomView: UIView!
    
    let disposeBag = DisposeBag()
    let viewModel = CityListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindObservers()
    }
    
    private func bindObservers() {
        viewModel.oCities
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: CityCell.identifier, cellType: CityCell.self)) { row, city, cell in
                cell.configure(city: city)
            }
            .disposed(by: disposeBag)
        
        bottomView.rx
            .anyGesture(.tap(), .swipe(direction: .up))
            .when(.recognized)
            .subscribe(onNext: { gesture in
                guard let addCityVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AddCityViewController.identifier) as? AddCityViewController else { return }
                addCityVC.modalPresentationStyle = .custom
                addCityVC.transitioningDelegate = addCityVC
                
                self.present(addCityVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

