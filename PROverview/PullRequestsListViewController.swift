import UIKit

class PullRequestsListViewController: UIViewController {

    var viewModel: PullRequestsListInterface
    
    init(viewModel: PullRequestsListInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPullRequestsData()
        viewModel.pullRequestCompletionHandler = { [weak self] in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableview)
        tableview.register(PullRequestDataTableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
    }

    private let tableview: UITableView = {
        let tableView = UITableView()
        tableView.accessibilityIdentifier = "tableView"
        return tableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
}

extension PullRequestsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pullRequestsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.pullRequestsList.count > 0 else {
            return UITableViewCell()
        }
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PullRequestDataTableViewCell else {
            return UITableViewCell()
        }

        cell.pullRequestDataModel = viewModel.pullRequestsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

