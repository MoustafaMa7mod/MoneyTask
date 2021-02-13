//
//  AccountsViewControllerTest.swift
//  MoneyAppTaskTests
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import XCTest
@testable import MoneyAppTask

class AccountsViewControllerTest: XCTestCase {

    var accountsViewController: AccountsViewController!
    let session = MockURLSession()

    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Accounts", bundle: nil)
        self.accountsViewController = storyboard.instantiateViewController(withIdentifier: String(describing: AccountsViewController.self)) as? AccountsViewController
        self.accountsViewController.loadView()
        self.accountsViewController.viewDidLoad()
        accountsViewController.accountsViewModel = AccountsViewModel(budgetObject: BudgetObject(id: "dc30a55d-5332-4bd0-9f0a-4f60cfa77636", name: "My Budget", firstMonth: "2021-02-01", lastMonth: "2021-02-01", dateFormat: DateFormat(format: "MM/DD/YYYY"), currencyFormat: CurrencyFormat()))


    }

    override func tearDownWithError() throws {
        self.accountsViewController = nil
    }
    
    
    func test_nav_title() {
        XCTAssertEqual(accountsViewController?.title , "Accounts")
         
    }
    
    func test_has_a_table_view() {
        XCTAssertNotNil(accountsViewController.accountsTableView)
    }
    
    func test_table_view_has_delegate() {
        XCTAssertNotNil(accountsViewController.accountsTableView.delegate)
    }
    
    func test_table_view_confroms_to_table_view_delegate_protocol() {
        XCTAssertTrue(accountsViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(accountsViewController.responds(to: #selector(accountsViewController.tableView(_:didSelectRowAt:))))
    }
    

    func test_table_view_has_data_source() {
        XCTAssertNotNil(accountsViewController.accountsTableView.dataSource)
    }
    
    func test_budget_id_not_nil() {
        XCTAssertNotNil(accountsViewController.accountsViewModel?.budgetObject.id)
    }
    
    
    func test_get_account_url() {
        guard let url = URL(string: URLS.getBudgetsAccounts(accountsViewController.accountsViewModel?.budgetObject.id ?? "")) else {
            return
        }
        XCTAssertNotNil(url)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)

        session.nextData = expectedData

        var actualData: AccountModel?
        let exp = expectation(description: "request")
        Networking.shared.getAllAccouts(accountsViewController.accountsViewModel?.budgetObject.id ?? "") { data, message in
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
        accountsViewController.accountsViewModel?.getData { loadData, message in
            loadDataDone = loadData
            messageRequest = message
            exp.fulfill()

        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(loadDataDone)
        XCTAssertNil(messageRequest)
    }

    func test_get_BBudget_count(){
        XCTAssertNotNil(accountsViewController.accountsViewModel?.getAccountCount())
    }
    
    
    

}
