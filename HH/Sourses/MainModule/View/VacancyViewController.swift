
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

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Введите в поиск название вакансии"
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.delegate = self
        return searchBar
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
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
        let gradientLayer = CAGradientLayer.magicCardGameBackgroundGradient()
        view.layer.insertSublayer(gradientLayer, at: 0)
        navigationItem.hidesSearchBarWhenScrolling = false
        view.addSubviews(searchBar, tableView)
    }

    private func setupLayout() {

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }

    private func listenForSearchTextChanges() {
        searchBar.searchTextField.textPublisher()
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

extension VacancyViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
