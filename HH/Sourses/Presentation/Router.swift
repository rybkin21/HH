
import UIKit

protocol RouterMain: AnyObject {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetailedInfo(with vacancyId: String)
    func popToRoot()
}

class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?

    init(navigationController: UINavigationController?, moduleBuilder: ModuleBuilderProtocol?) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let vacancyViewController = moduleBuilder?.createVacancy(router: self) else { return }
            navigationController.viewControllers = [vacancyViewController]
        }
    }

    func showDetailedInfo(with vacancyId: String) {
        if let navigationController = navigationController {
            guard let detailedInfoViewController = moduleBuilder?.createDetailedInfo(with: vacancyId, router: self) else {
                return
            }
            navigationController.pushViewController(detailedInfoViewController, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
