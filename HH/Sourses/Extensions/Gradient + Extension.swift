
import UIKit

extension CAGradientLayer {
    static func magicCardGameBackgroundGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = UIScreen.main.bounds

        let topColor = UIColor(red: 0.11, green: 0.15, blue: 0.5, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 0.95, green: 0.79, blue: 0.98, alpha: 1.0).cgColor

        gradientLayer.colors = [topColor, bottomColor]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        return gradientLayer
    }
}
