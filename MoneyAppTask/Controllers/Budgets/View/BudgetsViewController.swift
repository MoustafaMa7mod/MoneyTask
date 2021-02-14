//
//  BudgetsViewController.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import UIKit

class BudgetsViewController: UIViewController {

    // MARK:- outlets
    @IBOutlet weak var budgetTableView: UITableView!
    // MARK:- varaibles
    var budgetsViewModel =  BudgetsViewModel()
    
    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "Token: ",SaveData.shared.getAccessToken())
        setupNavBar()
        setupTableView()
        getData()

    }
    
    class func instantiateViewController() -> BudgetsViewController  {
        return UIStoryboard(name: "Budgets", bundle: nil).instantiateViewController(withIdentifier:  String(describing: BudgetsViewController.self)) as! BudgetsViewController
    }
    
    // MARK:- setup setting of navigation controller
    private func setupNavBar(){
        title = "Budgets"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK:- setup setting of table view
    private func setupTableView(){
        budgetTableView.registerCellNib(cellClass: BudgetCell.self)
        budgetTableView.delegate = self
        budgetTableView.dataSource = self
        budgetTableView.tableFooterView = UIView()
    }
    
    // MARK:- get data from server
    private func getData(){
        budgetsViewModel.getData(completion: { [weak self] loadData ,error in
            if loadData {
                DispatchQueue.main.async {
                    self?.budgetTableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self?.showErrorAlert("Alert \(error?.name ?? "")", error?.detail ?? "")
                }
                
            }
        })
    }
}
