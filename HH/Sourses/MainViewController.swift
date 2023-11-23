
import UIKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Outlets

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Введите в поиск название вакансии"
        return searchController
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(JobCell.self, forCellReuseIdentifier: JobCell.indentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray4
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.backgroundColor = .blue
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false

        view.backgroundColor = .systemTeal
        view.addSubviews(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Actions

    @objc private func buttonPressed() {

    }
}
