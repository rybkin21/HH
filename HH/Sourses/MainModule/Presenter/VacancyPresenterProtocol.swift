
import Foundation

protocol VacancyPresenterProtocol: AnyObject {
    var vacancyList: VacancyList? { get set }
    init(view: VacancyViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol)
    func fetchVacancy(path: String, page: Int)
    func didSelectVacancy(with vacancyId: String)
}
