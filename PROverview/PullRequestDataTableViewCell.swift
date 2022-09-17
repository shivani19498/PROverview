import Foundation
import UIKit

class PullRequestDataTableViewCell: UITableViewCell {
    
    var pullRequestDataModel: PullRequestDataModel? {
        didSet {
            populateData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subStackView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.accessibilityIdentifier = "mainStackView"
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var subStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateStackView, userStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.accessibilityIdentifier = "subStackView"
        return stackView
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [createdDate, closedDate])
        stackView.spacing = 10
        stackView.accessibilityIdentifier = "datesStackView"
        return stackView
    }()
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userImageView, userName])
        stackView.spacing = 5
        stackView.accessibilityIdentifier = "userStackView"
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.accessibilityIdentifier = "titleLabel"
        return label
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.accessibilityIdentifier = "userName"
        return label
    }()
    
    private let userImageView: UIImageView = {
        let image =  UIImageView()
        image.tintColor = .gray
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.widthAnchor.constraint(equalToConstant: 20).isActive = true
        image.heightAnchor.constraint(equalToConstant: 20).isActive = true
        image.accessibilityIdentifier = "userImageView"
        return image
    }()
    
    private lazy var createdDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.accessibilityIdentifier = "createdDate"
        return label
    }()
    
    private lazy var closedDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.accessibilityIdentifier = "closedDate"
        return label
    }()
    
    private func setupViews() {
        addSubview(mainStackView)
        var constraints = [mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)]
        constraints.append(mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10))
        constraints.append(mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5))
        constraints.append(mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5))

        NSLayoutConstraint.activate(constraints)
    }
    
    private func populateData() {
        titleLabel.text = pullRequestDataModel?.title
        userName.text = pullRequestDataModel?.user.login
        createdDate.text = pullRequestDataModel?.created_at
        closedDate.text = pullRequestDataModel?.closed_at
        userImageView.load(url: URL(string: pullRequestDataModel?.user.avatar_url ?? "")!)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
