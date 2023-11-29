
import UIKit

// MARK: - UITableVIew DataSource

extension VacancyViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.vacancyList?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VacancyCell.indentifier, for: indexPath) as? VacancyCell else { return UITableViewCell() }
        let selectedView = UIView()
        selectedView.backgroundColor = .systemCyan.withAlphaComponent(0.3)
        cell.selectedBackgroundView = selectedView
        let vacancyList = presenter.vacancyList
        cell.setupCell(vacancyList: vacancyList, at: indexPath.row)
        return cell
    }
}

// MARK: - UITableView Delegate

extension VacancyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let vacancyList = presenter.vacancyList else { return }
        if indexPath.row == vacancyList.items.count - 5 && vacancyList.items.count < vacancyList.pages {
            let path = searchBar.searchTextField.text ?? ""
            let page = (presenter.vacancyList?.page ?? 0) + 1
            presenter.fetchVacancy(path: path, page: page)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if let vacancyId = presenter.vacancyList?.items[indexPath.row].id {
            presenter.didSelectVacancy(with: vacancyId)
        }
    }
}
