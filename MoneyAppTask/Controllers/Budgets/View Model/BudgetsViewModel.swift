//
//  BudgetsViewModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import UIKit

class BudgetsViewModel: NSObject {

    var budgetsModel = BudgetsModel()

    func getData(completion: @escaping( Bool , String?) -> Void) {
        Networking.shared.getAllBudgets { [weak self] budgetModel, message in
            if let budgetModel = budgetModel {
                self?.budgetsModel = budgetModel
                completion(true , nil)
            }else{
                completion(false , message)
            }
        }
    }
    
    func getBudgetCount() -> Int {
        guard let count = budgetsModel.data?.budgets?.count else {
            return 0
        }
        return count
    }
    
    
    func getDetailsOfEachBudget(_ index: Int) -> BudgetObject {
        guard let object = self.budgetsModel.data?.budgets?[index] else {
            fatalError("faild to get data")
        }
        
        return object
    }
}
