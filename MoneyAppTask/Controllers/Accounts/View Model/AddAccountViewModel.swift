//
//  AddAccountViewModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import UIKit
import RxSwift
import RxCocoa

class AddAccountViewModel: NSObject {
    
    var selectedIndex = 0
    var budgetObject = BudgetObject()
    var accountType = String()
    var accountObject = AccountObject()

    
    
    var accountObjectModel = BehaviorRelay<AccountObject>(value: AccountObject())
    let accountTypeName =  BehaviorRelay<String>(value: "")
    let accountBalance = BehaviorRelay<String>(value: "")
    let accountTypeValue = BehaviorRelay<String>(value: "")
    var reloadView: () -> () = {  }

    
    
    
    init(budgetObject: BudgetObject) {
        self.budgetObject = budgetObject
    }
    
    
    func parseDataFromView () -> [String : [String : Any]] {
        self.accountObject.name = accountTypeName.value
        self.accountObject.balance = Int(accountBalance.value)
        self.accountObject.type = accountType
        
        let optionalDict = accountObject.dictionary
        let object = ["account": optionalDict ?? [:]]
        print(object)

        return object
    }

    
    
    func addAccountData(withParamter parameters: [String : [String : Any]] , Andcompletion completion: @escaping( Bool , String?) -> Void) {
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


extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
