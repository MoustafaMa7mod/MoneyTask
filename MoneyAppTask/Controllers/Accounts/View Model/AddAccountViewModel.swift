//
//  AddAccountViewModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import UIKit

class AddAccountViewModel: NSObject {
    
    var selectedIndex = 0
    var budgetObject = BudgetObject()
    var accountType = String()
    
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
    
 

}
