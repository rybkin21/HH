
import UIKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Outlets


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.backgroundColor = .systemMint
    }

    private func setupLayout() {

    }

    // MARK: - Actions

    @objc private func buttonPressed() {

    }
}
