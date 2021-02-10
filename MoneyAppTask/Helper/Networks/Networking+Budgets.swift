//
//  Networking+Budgets.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import Foundation


extension Networking {
    func getAllBudgets(completion: @escaping(BudgetsModel?, String?) -> Void) {
        request = Request(accessToken: accessToken, method: .get, body: nil)
        request?.request(URL(string: URLS.getBudgets)!, completion: { data, errorMessage in
            guard errorMessage == nil else{
                completion(nil , errorMessage)
                return
            }
            
            guard let data = data else {return}
            let budgetsModel = self.decode(type: BudgetsModel.self, data: data)
            completion(budgetsModel , nil)
        })
    }

}

