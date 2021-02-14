//
//  PayeeTransactionsVC+TableView.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/14/21.
//

import Foundation
import UIKit


extension PayeeTransactionsViewController: UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payeeTransactionsViewModel?.getPayeeTransactionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = payeeTransactionsTableView.dequeue() as PayeeTransactionsCell
        if let payeeTransactionsObject = payeeTransactionsViewModel?.getDetailsOfEachpayees(indexPath.row) {
            cell.configCell(payeeTransactionsObject , budgetObject?.currencyFormat?.currencySymbol ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

}
