import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var topLeftCorner: Bool {
        get {
            return layer.maskedCorners.contains(.layerMinXMinYCorner)
        }
        set {
            layer.maskedCorners.remove(.layerMinXMinYCorner)
            if (newValue) {
                layer.maskedCorners.insert(.layerMinXMinYCorner)
            }
        }
    }
    @IBInspectable var topRightCorner: Bool {
        get {
            return layer.maskedCorners.contains(.layerMaxXMinYCorner)
        }
        set {
            layer.maskedCorners.remove(.layerMaxXMinYCorner)
            if (newValue) {
                layer.maskedCorners.insert(.layerMaxXMinYCorner)
            }
        }
    }
    @IBInspectable var bottomLeftCorner: Bool {
        get {
            return layer.maskedCorners.contains(.layerMinXMaxYCorner)
        }
        set {
            layer.maskedCorners.remove(.layerMinXMaxYCorner)
            if (newValue) {
                layer.maskedCorners.insert(.layerMinXMaxYCorner)
            }
        }
    }
    @IBInspectable var bottomRightCorner: Bool {
        get {
            return layer.maskedCorners.contains(.layerMaxXMaxYCorner)
        }
        set {
            layer.maskedCorners.remove(.layerMaxXMaxYCorner)
            if (newValue) {
                layer.maskedCorners.insert(.layerMaxXMaxYCorner)
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}
