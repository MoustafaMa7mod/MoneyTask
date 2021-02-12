//
//  AddAccountViewModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import UIKit

class AddAccountViewModel: NSObject {
    var accountType = ["Checking" , "Savings" , "Cash" , "Credit Card" , "Line of Credit"]
    var accountTypeForServerArray = ["checking" , "savings" , "cash" , "creditCard" , "lineOfCredit"]
    var accountTypeForServerValue = String()
    
    var selectedIndex = 0
    var budgetObject = BudgetObject()
    
    init(budgetObject: BudgetObject) {
        self.budgetObject = budgetObject
    }

    
    
    func addAccountData(withParamter parameters: [String: Any] , Andcompletion completion: @escaping( Bool , String?) -> Void) {
        Networking.shared.addNewAccouts(budgetObject.id ?? "", parameters: parameters) { accountObject, message in
            if let accountModel = accountObject {
                print(accountModel)
                completion(true , nil)
            }else{
                completion(false , message)
            }

        }
    }
    
    func getAccountTypeCount() -> Int{
        return accountType.count
    }
    
    func getAccountTypeItem(_ index: Int) -> String{
        return accountType[index]
    }

}
