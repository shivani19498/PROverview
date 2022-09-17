import Foundation
import XCTest
@testable import PROverview

class PullRequestDataTableViewCellTests: XCTestCase {
    
    func testMainStackViewConfiguration() {
        let view = PullRequestDataTableViewCell()
        let mainStackView = view.findViewByIdentifier("mainStackView") as? UIStackView
        XCTAssertNotNil(mainStackView)
        XCTAssertEqual(mainStackView?.axis, .vertical)
        XCTAssertEqual(mainStackView?.spacing, 5)
        XCTAssertEqual(mainStackView?.arrangedSubviews.count, 2)
    }
    
    func testSubStackViewConfiguration() {
        let view = PullRequestDataTableViewCell()
        let subStackView = view.findViewByIdentifier("subStackView") as? UIStackView
        XCTAssertNotNil(subStackView)
        XCTAssertEqual(subStackView?.axis, .vertical)
        XCTAssertEqual(subStackView?.spacing, 0)
        XCTAssertEqual(subStackView?.arrangedSubviews.count, 2)
    }
    
    func testDateStackViewConfiguration() {
        let view = PullRequestDataTableViewCell()
        let dateStackView = view.findViewByIdentifier("datesStackView") as? UIStackView
        XCTAssertNotNil(dateStackView)
        XCTAssertEqual(dateStackView?.axis, .horizontal)
        XCTAssertEqual(dateStackView?.spacing, 10)
        XCTAssertEqual(dateStackView?.arrangedSubviews.count, 2)
    }
    
    func testUserStackViewConfiguration() {
        let view = PullRequestDataTableViewCell()
        let userStackView = view.findViewByIdentifier("userStackView") as? UIStackView
        XCTAssertNotNil(userStackView)
        XCTAssertEqual(userStackView?.axis, .horizontal)
        XCTAssertEqual(userStackView?.spacing, 5)
        XCTAssertEqual(userStackView?.arrangedSubviews.count, 2)
    }
    
    func testTitleLabelConfiguration() {
        let view = PullRequestDataTableViewCell()
        let titleLabel = view.findViewByIdentifier("titleLabel") as? UILabel
        let data = getPullRequestDataModelMock()
        view.pullRequestDataModel = data
        XCTAssertNotNil(titleLabel)
        XCTAssertEqual(titleLabel?.numberOfLines, 0)
        XCTAssertEqual(titleLabel?.lineBreakMode, .byWordWrapping)
        XCTAssertEqual(titleLabel?.textColor, .black)
        XCTAssertEqual(titleLabel?.font, .systemFont(ofSize: 14, weight: .bold))
        XCTAssertEqual(titleLabel?.text, "Pull Request Title")
    }
    
    func testUserNameViewConfiguration() {
        let view = PullRequestDataTableViewCell()
        let userName = view.findViewByIdentifier("userName") as? UILabel
        let data = getPullRequestDataModelMock()
        view.pullRequestDataModel = data
        XCTAssertNotNil(userName)
        XCTAssertEqual(userName?.numberOfLines, 0)
        XCTAssertEqual(userName?.lineBreakMode, .byWordWrapping)
        XCTAssertEqual(userName?.textColor, .black)
        XCTAssertEqual(userName?.font, .systemFont(ofSize: 14, weight: .regular))
        XCTAssertEqual(userName?.text, "username")
    }
    
    func testUserImageViewConfiguration() {
        let view = PullRequestDataTableViewCell()
        let userImageView = view.findViewByIdentifier("userImageView") as? UIImageView
        XCTAssertNotNil(userImageView)
        XCTAssertEqual(userImageView?.tintColor, .gray)
        XCTAssertEqual(userImageView?.contentMode, .scaleAspectFit)
        XCTAssertEqual(userImageView?.clipsToBounds, true)
    }
    
    func testCreatedDateConfiguration() {
        let view = PullRequestDataTableViewCell()
        let createdDate = view.findViewByIdentifier("createdDate") as? UILabel
        let data = getPullRequestDataModelMock()
        view.pullRequestDataModel = data
        XCTAssertNotNil(createdDate)
        XCTAssertEqual(createdDate?.numberOfLines, 0)
        XCTAssertEqual(createdDate?.lineBreakMode, .byWordWrapping)
        XCTAssertEqual(createdDate?.textColor, .black)
        XCTAssertEqual(createdDate?.font, .systemFont(ofSize: 14, weight: .regular))
        XCTAssertEqual(createdDate?.text, "date_created")
    }
    
    func testClosedDateConfiguration() {
        let view = PullRequestDataTableViewCell()
        let closedDate = view.findViewByIdentifier("closedDate") as? UILabel
        let data = getPullRequestDataModelMock()
        view.pullRequestDataModel = data
        XCTAssertNotNil(closedDate)
        XCTAssertEqual(closedDate?.numberOfLines, 0)
        XCTAssertEqual(closedDate?.lineBreakMode, .byWordWrapping)
        XCTAssertEqual(closedDate?.textColor, .black)
        XCTAssertEqual(closedDate?.font, .systemFont(ofSize: 14, weight: .regular))
        XCTAssertEqual(closedDate?.text, "date_closed")
    }
    
    private func getPullRequestDataModelMock() -> PullRequestDataModel {
        let user = User(login: "username", avatar_url: "url")
        let data = PullRequestDataModel(title: "Pull Request Title", user: user, created_at: "date_created", closed_at: "date_closed")
        return data
    }
}
