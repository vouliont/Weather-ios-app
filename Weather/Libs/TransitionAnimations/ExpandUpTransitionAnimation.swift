import UIKit

class ExpandUpTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    enum Action {
        case present, dismiss
    }
    
    private let action: Action
    
    init(action: Action) {
        self.action = action
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        let expandVC: AddCityViewController
        
        switch action {
        case .present:
            expandVC = toVC as! AddCityViewController
            expandVC.prepareToAnimation()
            
            containerView.addSubview(expandVC.view)
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                let scale = (fromVC.view.frame.height - 106) / fromVC.view.frame.height
                fromVC.view.transform = CGAffineTransform(scaleX: scale, y: scale)
                fromVC.view.clipsToBounds = true
                fromVC.view.layer.cornerRadius = 20
                (fromVC as? UINavigationController)?.topViewController?.view.backgroundColor = .tertiarySystemBackground
            })
        case .dismiss:
            expandVC = fromVC as! AddCityViewController
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                toVC.view.transform = .identity
                toVC.view.layer.cornerRadius = 0
                (toVC as? UINavigationController)?.topViewController?.view.backgroundColor = .systemBackground
            })
        }
        
        expandVC.animateTransition(action, duration: duration) { finished in
            if self.action == .dismiss {
                expandVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(true)
        }
    }
}
