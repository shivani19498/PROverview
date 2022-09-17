import Foundation
import XCTest
@testable import PROverview

class PullRequestsListViewControllerTests: XCTestCase {
    
    func testDealloc() {
        assertObjectWillDealloc {
            return PullRequestsListViewController(viewModel: PullRequestListInterfaceMock())
        }
    }
    
    func testFetchPullRequestIsCalledOnViewDidLoad() {
        let viewModel = PullRequestListInterfaceMock()
        let viewController = PullRequestsListViewController(viewModel: viewModel)
        viewController.viewDidLoad()
        XCTAssertTrue(viewModel.fetchPullRequestsDataCalled)
    }
    
    func testTableViewIsPresent() {
        let viewController = PullRequestsListViewController(viewModel: PullRequestListInterfaceMock())
        viewController.viewDidLoad()
        let view = viewController.view.findViewByIdentifier("tableView")
        XCTAssertNotNil(view)
    }
    
    func testTableViewCellHeight() {
        let viewController = PullRequestsListViewController(viewModel: PullRequestListInterfaceMock())
        let tableView = UITableView()
        let height = viewController.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(height, 110)
    }
    
    func testTableViewCellTypeWhenResultIsNonEmpty() {
        let viewController = PullRequestsListViewController(viewModel: PullRequestListInterfaceMock())
        viewController.viewDidLoad()
        let tableView = UITableView()
        let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is PullRequestDataTableViewCell)
    }
    
    func testTableViewCellTypeWhenResultIsEmpty() {
        let viewController = PullRequestsListViewController(viewModel: PullRequestListInterfaceMock())
        let tableView = UITableView()
        let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertFalse(cell is PullRequestDataTableViewCell)
    }
    
    func testTableViewNumberOfRows() {
        let viewController = PullRequestsListViewController(viewModel: PullRequestListInterfaceMock())
        viewController.viewDidLoad()
        let tableView = UITableView()
        let rows = viewController.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, 1)
    }
}

class PullRequestListInterfaceMock: PullRequestsListInterface {
    var pullRequestsList = [PullRequestDataModel]()
    
    var pullRequestCompletionHandlerCalled = false
    var fetchPullRequestsDataCalled = false
    
    var pullRequestCompletionHandler: (() -> Void)?
    
    func fetchPullRequestsData() {
        fetchPullRequestsDataCalled = true
        let user = User(login: "test", avatar_url: "test")
        pullRequestsList = [PullRequestDataModel(title: "test", user: user, created_at: "test", closed_at: "test")]
    }
}

extension XCTestCase {

    public func assertObjectWillDealloc(_ file: StaticString = #filePath, line: UInt = #line, createObject: () -> AnyObject) {
        weak var weakReference: AnyObject?

        autoreleasepool {
            let strongReference = createObject()
            if let viewController = strongReference as? UIViewController {
                _ = viewController.view
            }
            weakReference = strongReference
        }

        XCTAssertNil(weakReference, "weak reference not cleaned up, there may be a retain cycle", file: file, line: line)
    }
}

public extension UIView {

    @objc func findViewByIdentifier(_ identifier: String) -> UIView? {
        guard !identifier.isEmpty else { return nil }

        if accessibilityIdentifier == identifier {
            return self
        }

        for subview in subviews {
            if let found = subview.findViewByIdentifier(identifier) {
                return found
            }
        }
        return nil
    }
}
