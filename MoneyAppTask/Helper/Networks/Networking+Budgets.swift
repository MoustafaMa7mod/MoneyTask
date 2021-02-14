//
//  Networking+Budgets.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import Foundation


extension Networking {
    func getAllBudgets(completion: @escaping(BudgetsModel?, ErrorDetailsObject?) -> Void) {
        
        guard let url = URL(string: URLS.getBudgets) else {
            return
        }
        
        request = Request(accessToken: accessToken, method: .get, parameters: nil , session: URLSession.shared)
        
        request?.request(url, completion: { data, errorObject in
            guard errorObject == nil else{
                completion(nil , errorObject)
                return
            }
            
            guard let data = data else {return}
            let budgetsModel = self.decode(type: BudgetsModel.self, data: data)
            completion(budgetsModel , nil)
        })
    }

}

