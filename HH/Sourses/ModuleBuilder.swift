
import UIKit

protocol ModuleBuilderProtocol {
    func createVacancy(router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    func createVacancy(router: RouterProtocol) -> UIViewController {
        let networkClient = NetworkService()
        let view = VacancyViewController()
        let presenter = VacancyPresenter(view: view, router: router, networkService: networkClient)
        view.presenter = presenter
        return view
    }
}
