//
//  Networking+PayeeTransactions.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/14/21.
//

import Foundation

extension Networking {
    func getAllPayeeTransactions(_ budgetId: String, _ payeesId: String  , completion: @escaping(PayeeTransactionsModel?, ErrorDetailsObject?) -> Void) {
        
        let accountURL = URLS.getPayeeTransactions(budgetId,payeesId)
        print(accountURL)
        guard let url = URL(string: accountURL) else {
            return
        }
        
        request = Request(accessToken: accessToken, method: .get, parameters: nil , session: URLSession.shared)

        request?.request(url, completion: { data, errorObject in
            guard errorObject == nil else{
                completion(nil , errorObject)
                return
            }
            
            guard let data = data else {return}
            let payeeTransactionsModel = self.decode(type: PayeeTransactionsModel.self, data: data)
            completion(payeeTransactionsModel , nil)
        })
    }
    

}
