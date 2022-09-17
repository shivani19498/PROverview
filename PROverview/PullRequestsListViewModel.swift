import Foundation

struct User: Decodable {
    let login: String
    let avatar_url: String
}
struct PullRequestDataModel: Decodable {
    let title: String
    let user: User
    let created_at: String
    let closed_at: String
}

protocol PullRequestsListInterface {
    var pullRequestsList: [PullRequestDataModel] { get }
    var pullRequestCompletionHandler: (() -> Void)? { get set }
    func fetchPullRequestsData()
}

class PullRequestsListViewModel: PullRequestsListInterface {

    var pullRequestsList = [PullRequestDataModel]() {
        didSet {
            pullRequestCompletionHandler?()
        }
    }

    var pullRequestCompletionHandler: (() -> Void)?
    

    func fetchPullRequestsData() {
        let url = URL(string: "https://api.github.com/repos/TheAlgorithms/Python/pulls?state=closed")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            if let data = data {
            do {
                let dataModels = try JSONDecoder().decode([PullRequestDataModel].self, from: data)
                self.pullRequestsList = dataModels
            } catch _ {
                return
            }
          }
        }
        task.resume()
    }
}
