
import UIKit
import SnapKit
import Combine

protocol VacancyViewProtocol: AnyObject {
    func successfulLoadingVacancy()
}

class VacancyViewController: UIViewController {

    // MARK: - Outlets

    var presenter: VacancyPresenterProtocol!
    private var cancellabels = Set<AnyCancellable>()

     lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Введите в поиск название вакансии"
         searchController.searchBar.delegate = self
        return searchController
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(VacancyCell.self, forCellReuseIdentifier: VacancyCell.indentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        listenForSearchTextChanges()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
        view.addSubviews(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func listenForSearchTextChanges() {
        searchController.searchBar.searchTextField.textPublisher()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { (searchText) in
                if searchText.count >= 3 {
                    if self.presenter.vacancyList != nil {
                        self.presenter.vacancyList = nil
                    }
                    self.presenter.fetchVacancy(path: searchText, page: 0)
                } else {
                    self.resetVacancyList()
                }
            }
            .store(in: &cancellabels)
    }
}

extension VacancyViewController: VacancyViewProtocol {

    func successfulLoadingVacancy() {
        tableView.reloadData()
    }

    private func resetVacancyList() {
        presenter.vacancyList = nil
        tableView.reloadData()
    }
}

extension VacancyViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetVacancyList()
    }
}
