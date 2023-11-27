
import UIKit

class VacancyCell: UITableViewCell {

    static let indentifier = "VacancyCell"

    // MARK: - Outlets

    private lazy var vacancyTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var companyName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.layer.masksToBounds = true
        logo.contentMode = .scaleToFill
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    private lazy var requirementsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var responsibilitiesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupHierarchy()
        setupLayout()
    }

    override func layoutSubviews() {
        logoImage.layer.cornerRadius = logoImage.frame.width / 2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        logoImage.image = UIImage(systemName: "person.crop.circle.badge.questionmark.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
    }

    // MARK: - Setup

    private func setupHierarchy() {
        addSubviews(labelStack, logoImage)
        labelStack.addArrangedSubview(vacancyTitle)
        labelStack.addArrangedSubview(salaryLabel)
        labelStack.addArrangedSubview(companyName)
        labelStack.addArrangedSubview(requirementsLabel)
        labelStack.addArrangedSubview(responsibilitiesLabel)
    }

    private func setupLayout() {

        labelStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(logoImage.snp.leading).inset(-10)
            make.centerY.equalToSuperview()
        }

        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(15)
            make.height.width.equalTo(100)
        }
    }

    func setupCell(vacancyList: VacancyList?, at index: Int) {
        guard let job = vacancyList?.items[index] else { return }

        vacancyTitle.text = job.name

        if let fromSalary = job.salary?.from, let toSalary = job.salary?.to {
            salaryLabel.text = "от \(fromSalary) до \(toSalary) \(job.salary?.currency ?? "")"
        } else if let fromSalary = job.salary?.from, let currency = job.salary?.currency {
            salaryLabel.text = "\(fromSalary) \(currency)"
        } else {
            salaryLabel.text = "Заработная плата не указана"
        }

        companyName.text = job.employer?.name

        requirementsLabel.text = job.snippet?.requirement.map { "Требования: \($0.removingTags())" } ?? ""
        responsibilitiesLabel.text = job.snippet?.responsibility.map { "Обязанности: \($0.removingTags())" } ?? ""

        guard let imagePath = job.employer?.logoUrls?.original,
              let imageUrl = URL(string: imagePath)
        else {
            logoImage.image = UIImage(named: "sqare-image")
            return
        }
        loadImage(from: imageUrl)
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if error == nil, let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.logoImage.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.logoImage.image = UIImage(named: "square-image")
                }
            }
        }.resume()
    }
}
















