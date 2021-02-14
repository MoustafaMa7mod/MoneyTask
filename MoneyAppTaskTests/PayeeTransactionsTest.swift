//
//  PayeeTransactionsTest.swift
//  MoneyAppTaskTests
//
//  Created by Mostafa Mahmoud on 2/14/21.
//

import XCTest
@testable import MoneyAppTask

class PayeeTransactionsTest: XCTestCase {
    
    var payeeTransactionsViewController: PayeeTransactionsViewController!
    let session = MockURLSession()

    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "TransactionPayees", bundle: nil)
        self.payeeTransactionsViewController = storyboard.instantiateViewController(withIdentifier: String(describing: PayeeTransactionsViewController.self)) as? PayeeTransactionsViewController
        self.payeeTransactionsViewController.loadView()
        self.payeeTransactionsViewController.viewDidLoad()
        
        payeeTransactionsViewController.payeeTransactionsViewModel = PayeeTransactionsViewModel(budgetObject: BudgetObject(id: "dc30a55d-5332-4bd0-9f0a-4f60cfa77636", name: "My Budget", firstMonth: "2021-02-01", lastMonth: "2021-02-01", dateFormat: DateFormat(format: "MM/DD/YYYY"), currencyFormat: CurrencyFormat()), payeesObject: PayeesObject(id: "aa12e8dc-b1fc-431a-b60b-9244c911055c", name: "Starting Balance", transferAccountId: "", deleted: false))

    }

    override func tearDownWithError() throws {
        payeeTransactionsViewController = nil
    }
    
    func test_nav_title() {
        XCTAssertEqual(payeeTransactionsViewController?.title , "Payee Transactions")
         
    }
    
    func test_has_a_table_view() {
        XCTAssertNotNil(payeeTransactionsViewController.payeeTransactionsTableView)
    }
    
    func test_table_view_has_delegate() {
        XCTAssertNotNil(payeeTransactionsViewController.payeeTransactionsTableView.delegate)
    }
    
    func test_table_view_confroms_to_table_view_delegate_protocol() {
        XCTAssertTrue(payeeTransactionsViewController.conforms(to: UITableViewDelegate.self))
    }

    func test_table_view_has_data_source() {
        XCTAssertNotNil(payeeTransactionsViewController.payeeTransactionsTableView.dataSource)
    }
    
    func test_budget_id_not_nil() {
        XCTAssertNotNil(payeeTransactionsViewController.payeeTransactionsViewModel?.budgetObject.id)
    }
    
    func test_payee_id_not_nil() {
        XCTAssertNotNil(payeeTransactionsViewController.payeeTransactionsViewModel?.payeesObject.id)
    }
    
    
    func test_get_account_url() {
        guard let url = URL(string: URLS.getPayeeTransactions(payeeTransactionsViewController.payeeTransactionsViewModel?.budgetObject.id ?? "", payeeTransactionsViewController.payeeTransactionsViewModel?.payeesObject.id ?? "" )) else {
            return
        }
        XCTAssertNotNil(url)
    }

    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)

        session.nextData = expectedData

        var actualData: PayeeTransactionsModel?
        let exp = expectation(description: "request")
        Networking.shared.getAllPayeeTransactions(payeeTransactionsViewController.payeeTransactionsViewModel?.budgetObject.id ?? "", payeeTransactionsViewController.payeeTransactionsViewModel?.payeesObject.id ?? "") { data, message in
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
        payeeTransactionsViewController.payeeTransactionsViewModel?.getData { loadData, message in
            loadDataDone = loadData
            messageRequest = message
            exp.fulfill()

        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(loadDataDone)
        XCTAssertNil(messageRequest)
    }

    func test_get_BBudget_count(){
        XCTAssertNotNil(payeeTransactionsViewController.payeeTransactionsViewModel?.getPayeeTransactionsCount())
    }
    

}
