//
//  AccountsViewController.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import UIKit

class AccountsViewController: UIViewController {
    
    // MARK:- outlets
    @IBOutlet weak var accountsTableView: UITableView!
    
    // MARK:- varaibles
    var budgetObject: BudgetObject?
    var accountsViewModel: AccountsViewModel?
    
    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if let budgetObject =  budgetObject {
            accountsViewModel = AccountsViewModel(budgetObject: budgetObject)
        }
    
        setupNavBar()
        setupTableView()
        getData()
    }
    

    class func instantiateViewController() -> AccountsViewController  {
        return UIStoryboard(name: "Accounts", bundle: nil).instantiateViewController(withIdentifier:  String(describing: AccountsViewController.self)) as! AccountsViewController
    }
    
    // MARK:- setup setting of navigation controller
    private func setupNavBar(){
        title = "Accounts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(gotoAddAccount))
        navigationItem.rightBarButtonItem = add

    }
    
    // MARK: - actions
    @objc func gotoAddAccount(){
        let addAccountViewController = AddAccountViewController.instantiateViewController()
        addAccountViewController.budgetObject = self.accountsViewModel?.budgetObject
        addAccountViewController.paaData = { [weak self] in
            self?.getData()
        }
        let nav = MoneyAppNavigationController(rootViewController: addAccountViewController)
        self.present(nav , animated: true)
    }

    // MARK:- setup setting of table view
    private func setupTableView(){
        accountsTableView.registerCellNib(cellClass: AccountCell.self)
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        accountsTableView.tableFooterView = UIView()
        accountsTableView.estimatedRowHeight = 200
        accountsTableView.rowHeight = UITableView.automaticDimension

    }
    
    // MARK:- get data from server
    private func getData(){
        accountsViewModel?.getData(completion: { [weak self] loadData ,message in
            if loadData {
                DispatchQueue.main.async {
                    self?.accountsTableView.reloadData()
                }
            }else{
                print(message ?? "")
            }
        })
    }

}


