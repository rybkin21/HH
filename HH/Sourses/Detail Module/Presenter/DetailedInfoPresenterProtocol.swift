
import Foundation

protocol DetailedInfoPresenterProtocol: AnyObject {

    var vacancyId: String? { get set }

    init(view: DetailedInfoViewProtocol,
        networkService: NetworkServiceProtocol,
        router: RouterProtocol,
         vacancyId: String?)

    func fetchDetailedVacancy()
}
