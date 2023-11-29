
import Foundation

class DetailedInfoPresenter: DetailedInfoPresenterProtocol {

    // MARK: - Outlets

    weak var view: DetailedInfoViewProtocol?
    private var router: RouterProtocol?
    private var networkService: NetworkServiceProtocol!
    private var detailedInfo: DetailedInfo?
    var vacancyId: String?

    required init(view: DetailedInfoViewProtocol,
                  networkService: NetworkServiceProtocol,
                  router: RouterProtocol,
                  vacancyId: String?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.vacancyId = vacancyId
    }

    func fetchDetailedVacancy() {
        networkService.getVacancies(path: vacancyId ?? "",
                                    page: nil,
                                    method: .get,
                                    requestType: .detailedVacancy) {
            [weak self] (result: Result<DetailedInfo?, Error>) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let detailedInfo):
                strongSelf.detailedInfo = detailedInfo
                DispatchQueue.main.async {
                    strongSelf.view?.showDetailedInfo(detailedInfo)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
