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
        
        request = Request(accessToken: accessToken, method: .get, parameters: nil)

        request?.request(url, completion: { data, errorMessage in
            guard errorMessage == nil else{
                completion(nil , errorMessage)
                return
            }
            
            guard let data = data else {return}
            let accountsModel = self.decode(type: AccountModel.self, data: data)
            completion(accountsModel , nil)
        })
    }
    
    func addNewAccouts(_ budgetId: String ,_ lastKnowledgeOfServer: Int? = nil , parameters: [String : [String : Any]]  ,completion: @escaping(AddAccountModel?, String?) -> Void) {
        
        let accountURL = URLS.getBudgetsAccounts(budgetId, lastKnowledgeOfServer)
        guard let url = URL(string: accountURL) else {
            return
        }
        
        request = Request(accessToken: accessToken, method: .post, parameters: parameters)

        request?.request(url, completion: { data, errorMessage in
            guard errorMessage == nil else{
                completion(nil , errorMessage)
                return
            }
            
            guard let data = data else {return}
            let addAccountModel = self.decode(type: AddAccountModel.self, data: data)
            completion(addAccountModel , nil)
        })
    }

}
