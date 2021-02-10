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
        setupNavBar()
        setupTableView()
        getData()

    }
    
    class func instantiateViewController() -> BudgetsViewController  {
        return UIStoryboard(name: "Budgets", bundle: nil).instantiateViewController(withIdentifier:  String(describing: BudgetsViewController.self)) as! BudgetsViewController
    }
    private func setupNavBar(){
        title = "Budgets"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupTableView(){
        budgetTableView.registerCellNib(cellClass: BudgetCell.self)
        budgetTableView.delegate = self
        budgetTableView.dataSource = self
        budgetTableView.tableFooterView = UIView()
    }
    
    private func getData(){
        budgetsViewModel.getData(completion: { loadData ,message in
            if loadData {
                DispatchQueue.main.async {
                    self.budgetTableView.reloadData()
                }
            }else{
                print(message ?? "")
            }
        })
    }
}

extension BudgetsViewController: UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgetsViewModel.getBudgetCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = budgetTableView.dequeue() as BudgetCell
        let budget = budgetsViewModel.getDetailsOfEachBudget(indexPath.row)
        cell.configCell(budget)
        
        return cell
    }
    
    
}
