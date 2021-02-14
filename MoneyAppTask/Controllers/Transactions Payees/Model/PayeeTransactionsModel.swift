//
//  PayeeTransactionsModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/14/21.
//

import Foundation

struct PayeeTransactionsModel: Codable {
    var data: PayeeTransactions?
}


struct PayeeTransactions: Codable {
    var transactions: [PayeeTransactionsObject]?
}


struct PayeeTransactionsObject: Codable {
    var type: String?
    var id: String?
    var date: String?
    var amount: Int?
    var approved: Bool?
    var accountName: String?
    var payeeName: String?
    var deleted: Bool?
    var accountId: String?
    var payeeId: String?
    var categoryId: String?
    var categoryName: String?
    
    enum CodingKeys: String, CodingKey {
        case type , id, date , amount , approved , deleted
        case accountName = "account_name"
        case payeeName = "payee_name"
        case accountId = "account_id"
        case payeeId = "payee_id"
        case categoryId = "category_id"
        case categoryName = "category_name"
    }
}
