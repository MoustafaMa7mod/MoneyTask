//
//  PayeesViewControllerTest.swift
//  MoneyAppTaskTests
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import XCTest
@testable import MoneyAppTask

class PayeesViewControllerTest: XCTestCase {

    var payeesViewController: PayeesViewController!
    let session = MockURLSession()

    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "TransactionPayees", bundle: nil)
        self.payeesViewController = storyboard.instantiateViewController(withIdentifier: String(describing: PayeesViewController.self)) as? PayeesViewController
        self.payeesViewController.loadView()
        self.payeesViewController.viewDidLoad()
        payeesViewController.payeesViewModel = PayeesViewModel(budgetObject: BudgetObject(id: "dc30a55d-5332-4bd0-9f0a-4f60cfa77636", name: "My Budget", firstMonth: "2021-02-01", lastMonth: "2021-02-01", dateFormat: DateFormat(format: "MM/DD/YYYY"), currencyFormat: CurrencyFormat()))


    }

    override func tearDownWithError() throws {
        self.payeesViewController = nil
    }
    
    
    func test_nav_title() {
        XCTAssertEqual(payeesViewController?.title , "Payess")
         
    }
    
    func test_has_a_table_view() {
        XCTAssertNotNil(payeesViewController.payessTableView)
    }
    
    func test_table_view_has_delegate() {
        XCTAssertNotNil(payeesViewController.payessTableView.delegate)
    }
    
    func test_table_view_confroms_to_table_view_delegate_protocol() {
        XCTAssertTrue(payeesViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(payeesViewController.responds(to: #selector(payeesViewController.tableView(_:didSelectRowAt:))))
    }

    func test_table_view_has_data_source() {
        XCTAssertNotNil(payeesViewController.payessTableView.dataSource)
    }
    
    func test_budget_id_not_nil() {
        XCTAssertNotNil(payeesViewController.payeesViewModel?.budgetObject.id)
    }
    
    
    func test_get_account_url() {
        guard let url = URL(string: URLS.getBudgetsAccounts(payeesViewController.payeesViewModel?.budgetObject.id ?? "")) else {
            return
        }
        XCTAssertNotNil(url)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)

        session.nextData = expectedData

        var actualData: PayeesModel?
        let exp = expectation(description: "request")
        Networking.shared.getAllPayees(payeesViewController.payeesViewModel?.budgetObject.id ?? "") { data, message in
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
        payeesViewController.payeesViewModel?.getData { loadData, message in
            loadDataDone = loadData
            messageRequest = message
            exp.fulfill()

        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(loadDataDone)
        XCTAssertNil(messageRequest)
    }

    func test_get_BBudget_count(){
        XCTAssertNotNil(payeesViewController.payeesViewModel?.getPayeesCount())
    }

}
