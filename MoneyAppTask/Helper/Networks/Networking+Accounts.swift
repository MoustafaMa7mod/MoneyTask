//
//  Networking+Accounts.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import Foundation

extension Networking {
    func getAllAccouts(_ budgetId: String ,_ lastKnowledgeOfServer: Int? = nil  ,completion: @escaping(AccountModel?, String?) -> Void) {
        
        let accountURL = URLS.getBudgetsAccounts(budgetId, lastKnowledgeOfServer)
        print(accountURL)
        guard let url = URL(string: accountURL) else {
            return
        }
        
        request = Request(accessToken: accessToken, method: .get, body: nil)

        request?.request(url, completion: { data, errorMessage in
            guard errorMessage == nil else{
                completion(nil , errorMessage)
                return
            }
            
            guard let data = data else {return}
            let budgetsModel = self.decode(type: AccountModel.self, data: data)
            completion(budgetsModel , nil)
        })
    }

}
