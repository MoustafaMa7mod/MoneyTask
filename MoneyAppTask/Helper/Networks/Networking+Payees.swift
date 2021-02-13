//
//  Networking+Payees.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import Foundation

extension Networking {
    func getAllPayees(_ budgetId: String , completion: @escaping(PayeesModel?, String?) -> Void) {
        
        let accountURL = URLS.getPayees(budgetId)
        print(accountURL)
        guard let url = URL(string: accountURL) else {
            return
        }
        
        request = Request(accessToken: accessToken, method: .get, parameters: nil , session: URLSession.shared)

        request?.request(url, completion: { data, errorMessage in
            guard errorMessage == nil else{
                completion(nil , errorMessage)
                return
            }
            
            guard let data = data else {return}
            let payeesModel = self.decode(type: PayeesModel.self, data: data)
            completion(payeesModel , nil)
        })
    }
    

}
