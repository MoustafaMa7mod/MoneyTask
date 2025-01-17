//
//  URLS.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import Foundation


struct URLS {
    static let mainURL = "https://api.youneedabudget.com/v1/"
    static let getBudgets = mainURL + "budgets"
    static func getBudgetsAccounts(_ budgetId: String , _ lastKnowledgeOfServer: Int? = nil) -> String {
        var accountURL = getBudgets + "/\(budgetId)/accounts"
        
        if let lastKnowledgeOfServer = lastKnowledgeOfServer {
            accountURL  = getBudgets + "budgets\(budgetId)/accounts?last_knowledge_of_server=\(String(lastKnowledgeOfServer))"
            
        }
        return accountURL
    }
    
    
    static func getPayees(_ budgetId: String) -> String {
        let payeeURL = getBudgets + "/\(budgetId)/payees"
        return payeeURL
    }
    
    static func getPayeeTransactions(_ budgetId: String, _ payeesId: String) -> String {
        let payeeTransactionsURL = getBudgets + "/\(budgetId)/payees/\(payeesId)/transactions"
        return payeeTransactionsURL
    }

}
