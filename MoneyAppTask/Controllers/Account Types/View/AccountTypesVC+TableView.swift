//
//  AccountTypesVC+TableView.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import Foundation
import UIKit

extension AccountTypesViewController: UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return accountTypesViewModel.getNumberOfsection()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return accountTypesViewModel.getSectionTitleHeader(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountTypesViewModel.getCountOfEachSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = accountTypeTableView.dequeue() as AccountTypeCell
        let accountType = accountTypesViewModel.getItemOfEachSection(indexPath.section, indexPath.row).key
        cell.configCell(accountType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountType = accountTypesViewModel.getItemOfEachSection(indexPath.section, indexPath.row)
        self.passData?(accountType.key , accountType.value)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
}
