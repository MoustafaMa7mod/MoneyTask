//
//  AddAccountViewControllerTest.swift
//  MoneyAppTaskTests
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import XCTest
@testable import MoneyAppTask

class AddAccountViewControllerTest: XCTestCase {

    var accountsViewController: AddAccountViewController!
    let session = MockURLSession()

    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Accounts", bundle: nil)
        self.accountsViewController = storyboard.instantiateViewController(withIdentifier: String(describing: AddAccountViewController.self)) as? AddAccountViewController
        self.accountsViewController.loadView()
        self.accountsViewController.viewDidLoad()
        accountsViewController.addAccountViewModel = AddAccountViewModel(budgetObject: BudgetObject(id: "dc30a55d-5332-4bd0-9f0a-4f60cfa77636", name: "My Budget", firstMonth: "2021-02-01", lastMonth: "2021-02-01", dateFormat: DateFormat(format: "MM/DD/YYYY"), currencyFormat: CurrencyFormat()))


    }

    override func tearDownWithError() throws {
        self.accountsViewController = nil
    }
    
    func test_nav_title() {
        XCTAssertEqual(accountsViewController?.title , "Add Account")
    }
    
    func test_has_view_controller_outlets(){
        XCTAssertNotNil(accountsViewController.accountNameTextField)
        XCTAssertNotNil(accountsViewController.balanceTextField)
        XCTAssertNotNil(accountsViewController.accountTypeTextField)
    }

    func test_get_account_url() {
        guard let url = URL(string: URLS.getBudgetsAccounts(accountsViewController.addAccountViewModel?.budgetObject.id ?? "")) else {
            return
        }
        XCTAssertNotNil(url)
    }
    
    func test_request_should_return_data() {
        let expectedData = "{}".data(using: .utf8)

        session.nextData = expectedData

        var actualData: AddAccountModel?
        let exp = expectation(description: "request")
        Networking.shared.addNewAccouts(accountsViewController.addAccountViewModel?.budgetObject.id ?? "", parameters: ["account": ["name":"test add new account" , "type":"checking" , "balance":"20"]]) { data, message in

            actualData = data
            exp.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(actualData)
    }
    
    



}
