//
//  AccountTypesViewController.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import UIKit

class AccountTypesViewController: UIViewController {
    
    // MARK:- outlets
    @IBOutlet weak var accountTypeTableView: UITableView!
    
    // MARK:- varaibles
    var accountTypesViewModel = AccountTypesViewModel()
    var passData:((String , String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
    }
    
    class func instantiateViewController() -> AccountTypesViewController  {
        return UIStoryboard(name: "AccountTypes", bundle: nil).instantiateViewController(withIdentifier:  String(describing: AccountTypesViewController.self)) as! AccountTypesViewController
    }
    
    // MARK:- setup setting of navigation controller
    private func setupNavBar(){
        title = "Account Types"
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(backToAddAccount))
        navigationItem.leftBarButtonItem = cancel

    }
    
    // MARK: - actions
    @objc func backToAddAccount(){
        self.dismiss(animated: true, completion: nil)
    }
    // MARK:- setup setting of table view
    private func setupTableView(){
        accountTypeTableView.registerCellNib(cellClass: AccountTypeCell.self)
        accountTypeTableView.delegate = self
        accountTypeTableView.dataSource = self
        accountTypeTableView.tableFooterView = UIView()

    }
    
    

}
