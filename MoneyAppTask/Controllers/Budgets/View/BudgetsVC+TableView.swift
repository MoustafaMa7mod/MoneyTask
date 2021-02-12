//
//  File.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import Foundation
import UIKit

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let budget = budgetsViewModel.getDetailsOfEachBudget(indexPath.row)

        let accountsViewController = AccountsViewController.instantiateViewController()
        accountsViewController.budgetObject = budget
        self.navigationController?.pushViewController(accountsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
}
