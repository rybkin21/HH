
import UIKit

protocol ModuleBuilderProtocol {
    func createVacancy(router: RouterProtocol) -> UIViewController
    func createDetailedInfo(with vacancyId: String?, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    func createVacancy(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = VacancyViewController()
        let presenter = VacancyPresenter(view: view, router: router, networkService: networkService)
        view.presenter = presenter
        return view
    }

    func createDetailedInfo(with vacancyId: String?, router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = DetailedInfoViewController()
        let presenter = DetailedInfoPresenter(view: view, networkService: networkService, router: router, vacancyId: vacancyId)
        presenter.vacancyId = vacancyId
        view.presenter = presenter
        return view
    }
}
