import Foundation
import XCTest
@testable import PROverview

class PullRequestsListViewModelTests: XCTestCase {
    
    func testFetchPullRequestsData() {
        let viewModel = PullRequestsListViewModel()
        XCTAssertEqual(viewModel.pullRequestsList.count, 0)
        viewModel.fetchPullRequestsData()
        XCTAssertEqual(viewModel.pullRequestsList.count, 0)
    }
}
