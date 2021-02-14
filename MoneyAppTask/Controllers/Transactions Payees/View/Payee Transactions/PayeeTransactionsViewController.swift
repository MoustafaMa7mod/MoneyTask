//
//  PayeeTransactionsViewController.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/14/21.
//

import UIKit

class PayeeTransactionsViewController: UIViewController {
    // MARK:- outlets
    @IBOutlet weak var payeeTransactionsTableView: UITableView!
    
    // MARK:- varaibles
    var budgetObject: BudgetObject?
    var payeesObject: PayeesObject?

    var payeeTransactionsViewModel: PayeeTransactionsViewModel?

    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if let budgetObject =  budgetObject , let payeesObject = payeesObject {
            payeeTransactionsViewModel = PayeeTransactionsViewModel(budgetObject: budgetObject , payeesObject: payeesObject)
        }
        setupNavBar()
        setupTableView()
        getData()
    }
    
    class func instantiateViewController() -> PayeeTransactionsViewController  {
        return UIStoryboard(name: "TransactionPayees", bundle: nil).instantiateViewController(withIdentifier:  String(describing: PayeeTransactionsViewController.self)) as! PayeeTransactionsViewController
    }
    
    // MARK:- setup setting of navigation controller
    private func setupNavBar(){
        title = "Payee Transactions"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

    }
    


    // MARK:- setup setting of table view
    private func setupTableView(){
        payeeTransactionsTableView.registerCellNib(cellClass: PayeeTransactionsCell.self)
        payeeTransactionsTableView.delegate = self
        payeeTransactionsTableView.dataSource = self
        payeeTransactionsTableView.tableFooterView = UIView()

    }
    
    // MARK:- get data from server
    private func getData(){
        LoadingIndicatorView.show("Loading")

        payeeTransactionsViewModel?.getData(completion: { [weak self] loadData ,error in
            DispatchQueue.main.async {
                LoadingIndicatorView.hide()
            }

            if loadData {
                DispatchQueue.main.async {
                    self?.payeeTransactionsTableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self?.showErrorAlert("Alert \(error?.name ?? "")", error?.detail ?? "")
                }
            }
        })
    }

}
