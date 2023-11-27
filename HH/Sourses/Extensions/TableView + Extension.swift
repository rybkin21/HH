
import UIKit

// MARK: - UITableVIew DataSource

extension VacancyViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.vacancyList?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VacancyCell.indentifier, for: indexPath) as? VacancyCell else { return UITableViewCell() }
        let vacancyList = presenter.vacancyList
        cell.setupCell(vacancyList: vacancyList, at: indexPath.row)
        return cell
    }
}

// MARK: - UITableView Delegate

extension VacancyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let detailVC = DetailViewController()
//        detailVC.selectedCard = cards[indexPath.row]
//        navigationController?.pushViewController(detailVC, animated: true)
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//    }
}

