//
//  PayeesViewModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import UIKit

class PayeesViewModel: NSObject {
    
    var payeesModel = PayeesModel()
    var budgetObject = BudgetObject()
    
    init(budgetObject: BudgetObject) {
        self.budgetObject = budgetObject
    }
    
    
    func getData(completion: @escaping( Bool , ErrorDetailsObject?) -> Void) {
        Networking.shared.getAllPayees(budgetObject.id ?? "") { [weak self] payessModelObject, error in
            if let payessModelObject = payessModelObject {
                self?.payeesModel = payessModelObject
                completion(true , nil)
            }else{
                completion(false , error)
            }
        }
    }
    
    func getPayeesCount() -> Int {
        guard let count = self.payeesModel.data?.payees?.count else {
            return 0
        }
        
        return count
    }
    
    
    func getDetailsOfEachpayees(_ index: Int) -> PayeesObject {
        guard let object = self.payeesModel.data?.payees?[index] else {
            fatalError("faild to get data")
        }
        
        return object
    }
}

