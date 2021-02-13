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
        if section == 0 {
            return accountTypesViewModel.getCountOfBudgetSection()
        }else{
            return accountTypesViewModel.getCountOfTrackingSection()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = accountTypeTableView.dequeue() as AccountTypeCell
        var type = String()
        if indexPath.section == 0{
            type = accountTypesViewModel.getItemOfBudgetSection(indexPath.row)
            cell.configCell(type)
        }else{
            type = accountTypesViewModel.getItemOfTrackingSection(indexPath.row)
            cell.configCell(type)

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            self.passData?(accountTypesViewModel.getItemOfBudgetSection(indexPath.row) , accountTypesViewModel.getItemOfBudgetSectionValue(indexPath.row))
        }else{
            self.passData?(accountTypesViewModel.getItemOfTrackingSection(indexPath.row) , accountTypesViewModel.getItemOfTrackingSectionValue(indexPath.row))
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    
    
}
