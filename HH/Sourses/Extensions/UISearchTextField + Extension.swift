
import UIKit
import Combine

extension UISearchTextField {

    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UISearchTextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }
}
