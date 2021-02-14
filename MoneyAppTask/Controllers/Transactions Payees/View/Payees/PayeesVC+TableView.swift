//
//  PayeesVC.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import Foundation
import UIKit


extension PayeesViewController: UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payeesViewModel?.getPayeesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = payessTableView.dequeue() as PayeesCell
        if let payees = payeesViewModel?.getDetailsOfEachpayees(indexPath.row) {
            cell.configCell(payees)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let budget = payeesViewModel?.budgetObject
        let payees = payeesViewModel?.getDetailsOfEachpayees(indexPath.row)

        let payeeTransactionsViewController = PayeeTransactionsViewController.instantiateViewController()
        payeeTransactionsViewController.budgetObject = budget
        payeeTransactionsViewController.payeesObject = payees
        self.navigationController?.pushViewController(payeeTransactionsViewController, animated: true)

    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
