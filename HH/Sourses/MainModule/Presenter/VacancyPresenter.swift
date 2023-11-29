
import Foundation

class VacancyPresenter: VacancyPresenterProtocol {

    // MARK: - Outlets

    weak var view: VacancyViewProtocol?
    private var router: RouterProtocol?
    private let networkService: NetworkServiceProtocol!
    var vacancyList: VacancyList?

    required init(view: VacancyViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }

    func fetchVacancy(path: String, page: Int) {
        networkService.getVacancies(path: path,
                                    page: page,
                                    method: .get,
                                    requestType: .vacancyList) { [weak self] (result: Result<VacancyList?, Error>) in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let vacancyList):
                    if self?.vacancyList == nil {
                        self?.vacancyList = vacancyList
                        strongSelf.view?.successfulLoadingVacancy()
                    } else {
                        if let vacancyList = vacancyList {
                            self?.vacancyList?.items.append(contentsOf: vacancyList.items)
                            self?.vacancyList?.page = vacancyList.page
                            strongSelf.view?.successfulLoadingVacancy()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func didSelectVacancy(with vacancyId: String) {
        router?.showDetailedInfo(with: vacancyId)
    }
}
