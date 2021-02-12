//
//  AccountModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import Foundation

struct AccountModel: Codable {
    var data: Accounts?
}

struct Accounts: Codable {
    var accounts: [AccountObject]?
}
struct AccountObject: Codable {
    var id: String?
    var name: String?
    var type: String?
    var onBudget: Bool?
    var closed: Bool?
    var balance: Int?
    var note: String?
    var clearedBalance: Int?
    var unclearedBalance: Int?
    var transferPayeeId: String?
    var deleted: Bool?
    enum CodingKeys: String, CodingKey {
        case id , name, type , closed , balance , deleted , note
        case onBudget = "on_budget"
        case clearedBalance = "cleared_balance"
        case unclearedBalance = "uncleared_balance"
        case transferPayeeId = "transfer_payee_id"
    }
    
}
