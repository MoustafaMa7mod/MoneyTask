//
//  BudgetsViewControllerTest.swift
//  MoneyAppTaskTests
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import XCTest
@testable import MoneyAppTask

class BudgetsViewControllerTest: XCTestCase {

    var budgetsViewController: BudgetsViewController!
    let session = MockURLSession()

    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Budgets", bundle: nil)
        self.budgetsViewController = storyboard.instantiateViewController(withIdentifier: String(describing: BudgetsViewController.self)) as? BudgetsViewController
        self.budgetsViewController.loadView()
        self.budgetsViewController.viewDidLoad()

    }

    override func tearDownWithError() throws {
        self.budgetsViewController = nil
    }
    
    func test_nav_title() {
        XCTAssertEqual(budgetsViewController?.title , "Budgets")
    }
    
    func test_has_a_table_view() {
        XCTAssertNotNil(budgetsViewController.budgetTableView)
    }
    
    func test_table_view_has_delegate() {
        XCTAssertNotNil(budgetsViewController.budgetTableView.delegate)
    }
    
    func test_table_view_confroms_to_table_view_delegate_protocol() {
        XCTAssertTrue(budgetsViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(budgetsViewController.responds(to: #selector(budgetsViewController.tableView(_:didSelectRowAt:))))
    }

    func test_table_view_has_data_source() {
        XCTAssertNotNil(budgetsViewController.budgetTableView.dataSource)
    }

    func test_get_budgets_url() {
        guard let url = URL(string: URLS.getBudgets) else {
            return
        }
        XCTAssertNotNil(url)
    }


    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)

        session.nextData = expectedData

        var actualData: BudgetsModel?
        let exp = expectation(description: "request")
        Networking.shared.getAllBudgets { data, message in
            actualData = data
            exp.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(actualData)
    }
    
    func test_loaded_data() {
        var loadDataDone = Bool()
        var messageRequest: String?
        let exp = expectation(description: "request")
        budgetsViewController.budgetsViewModel.getData { loadData, message in
            loadDataDone = loadData
            messageRequest = message
            exp.fulfill()

        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(loadDataDone)
        XCTAssertNil(messageRequest)
    }
    
    func test_get_BBudget_count(){
        XCTAssertNotNil(budgetsViewController.budgetsViewModel.getBudgetCount())
    }
    

}
