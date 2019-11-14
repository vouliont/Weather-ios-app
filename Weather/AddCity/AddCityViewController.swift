import UIKit
import MapKit
import RxSwift

class AddCityViewController: UIViewController {
    @IBOutlet var swipeView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var addCityLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var okButton: UIButton!
    
    static let identifier = "addCityViewController"
    
    let viewModel = AddCityViewModel()
    let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        bindObservers()
    }
    
    private func initialSetup() {
        viewModel.oCoordinate
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { coordinate in
                let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: false)
            })
            .dispose()
    }
    
    private func bindObservers() {
        cancelButton.rx
            .tapGesture()
            .subscribe(onNext: { tap in
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        okButton.rx
            .tapGesture()
            .subscribe(onNext: { tap in
                
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - animations
extension AddCityViewController {
    func prepareToAnimation() {
        cityNameLabel.alpha = 0

        let swipeViewHeight = swipeView.frame.height
        let containerViewHeight = containerView.frame.height
        containerView.transform = CGAffineTransform(translationX: 0, y: containerViewHeight - swipeViewHeight)
    }
    
    func animateTransition(_ action: ExpandUpTransitionAnimation.Action, duration: TimeInterval, completionHandler: ((_ finished: Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            switch action {
            case .present:
                self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3044734589)
                self.containerView.transform = .identity
                self.cityNameLabel.alpha = 1
                self.addCityLabel.alpha = 0
            case .dismiss:
                self.view.backgroundColor = .clear
                let swipeViewHeight = self.swipeView.frame.height
                let containerViewHeight = self.containerView.frame.height
                self.containerView.transform = CGAffineTransform(translationX: 0, y: containerViewHeight - swipeViewHeight)
                self.cityNameLabel.alpha = 0
                self.addCityLabel.alpha = 1
            }
        }, completion: completionHandler)
    }
}

extension AddCityViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ExpandUpTransitionAnimation(action: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ExpandUpTransitionAnimation(action: .dismiss)
    }
}

extension AddCityViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinate = mapView.centerCoordinate
        viewModel.iCoordinate.onNext(coordinate)
    }
}
