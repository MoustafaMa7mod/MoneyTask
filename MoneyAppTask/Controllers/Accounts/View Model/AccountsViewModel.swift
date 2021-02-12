//
//  AccountsViewModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import UIKit

class AccountsViewModel: NSObject {
    
    var accountsArray = [AccountObject]()
    var budgetObject = BudgetObject()
    
    init(budgetObject: BudgetObject) {
        self.budgetObject = budgetObject
    }
    
    
    func getData(completion: @escaping( Bool , String?) -> Void) {
        Networking.shared.getAllAccouts(budgetObject.id ?? "") { [weak self] accountModel , message in
            if let accountModel = accountModel {
                guard let filterArrray = accountModel.data?.accounts?.filter({$0.deleted == false}) else {
                    return
                }
                self?.accountsArray = filterArrray.sorted(by: {$0.balance ?? 0 > $1.balance ?? 0})

                completion(true , nil)
            }else{
                completion(false , message)
            }
            
        }
        
    }
    
    func getAccountCount() -> Int {
        return accountsArray.count
    }
    
    
    func getDetailsOfEachAccout(_ index: Int) -> AccountObject {
        return accountsArray[index]
    }
    
    
    
}
