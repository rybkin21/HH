
import UIKit
import SnapKit

protocol DetailedInfoViewProtocol: AnyObject {
    func showDetailedInfo(_ detailedInfo: DetailedInfo?)
}

import UIKit
import SnapKit

class DetailedInfoViewController: UIViewController {

    // MARK: - Outlets

    var presenter: DetailedInfoPresenterProtocol!

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()

    private lazy var vacancyTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchDetailedVacancy()
        setupHierarchy()
        setupLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentView.frame.height)
    }
    // MARK: - Setup

    private func setupHierarchy() {
        let gradientLayer = CAGradientLayer.magicCardGameBackgroundGradient()
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(vacancyTitle)
        stackView.addArrangedSubview(salaryLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(adressLabel)
    }

    private func setupLayout() {

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}

extension DetailedInfoViewController: DetailedInfoViewProtocol {

    func showDetailedInfo(_ detailedInfo: DetailedInfo?) {
        DispatchQueue.main.async { [weak self] in
            self?.vacancyTitle.text = detailedInfo?.name
            if detailedInfo?.salary?.from != nil && detailedInfo?.salary?.to != nil {
                self?.salaryLabel.text = "от \(detailedInfo?.salary?.from ?? 0) до \(detailedInfo?.salary?.to ?? 0) \(detailedInfo?.salary?.currency ?? "")"
            } else if detailedInfo?.salary?.from != nil && detailedInfo?.salary?.currency != nil {
                self?.salaryLabel.text = "\(detailedInfo?.salary?.from ?? 0) \(detailedInfo?.salary?.currency ?? "")"
            } else {
                self?.salaryLabel.text = "Заработная плата не указана"
            }
            self?.descriptionLabel.text = detailedInfo?.description
            self?.descriptionLabel.attributedText = detailedInfo?.description?.attributedStringFromHTML
            self?.adressLabel.text = detailedInfo?.area?.name
        }
    }
}
