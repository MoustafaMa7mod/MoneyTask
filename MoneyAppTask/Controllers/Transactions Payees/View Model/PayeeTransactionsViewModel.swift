//
//  PayeeTransactionsViewModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/14/21.
//

import UIKit

class PayeeTransactionsViewModel: NSObject {
    var payeeTransactionsModel = PayeeTransactionsModel()
    var budgetObject = BudgetObject()
    var payeesObject = PayeesObject()
    
    init(budgetObject: BudgetObject , payeesObject: PayeesObject) {
        self.budgetObject = budgetObject
        self.payeesObject = payeesObject
    }
    
    
    func getData(completion: @escaping( Bool , ErrorDetailsObject?) -> Void) {
        Networking.shared.getAllPayeeTransactions(budgetObject.id ?? "", payeesObject.id ?? "") { [weak self] payeeTransactionModelObject, error in
            if let payeeTransactionModelObject = payeeTransactionModelObject {
                self?.payeeTransactionsModel = payeeTransactionModelObject
                completion(true , nil)
            }else{
                completion(false , error)
            }
        }
    }
    
    func getPayeeTransactionsCount() -> Int {
        guard let count = self.payeeTransactionsModel.data?.transactions?.count else {
            return 0
        }

        return count
    }


    func getDetailsOfEachpayees(_ index: Int) -> PayeeTransactionsObject {
        guard let object = self.payeeTransactionsModel.data?.transactions?[index] else {
            fatalError("faild to get data")
        }

        return object
    }

}
