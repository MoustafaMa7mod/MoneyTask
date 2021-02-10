//
//  BudgetModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import Foundation


struct BudgetsModel: Codable {
    var data: Budgets?
}

struct Budgets: Codable {
    var budgets: [BudgetObject]?
}

struct BudgetObject : Codable {
    var id: String?
    var name: String?
    var firstMonth: String?
    var lastMonth: String?
    var dateFormat: DateFormat?
    var currencyFormat: CurrencyFormat?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstMonth = "first_month"
        case lastMonth = "last_month"
        case dateFormat = "date_format"
        case currencyFormat = "currency_format"
    }
    
}


public struct DateFormat: Codable {
    var format: String?
}

struct CurrencyFormat: Codable {
    var isoCode: String?
    var exampleFormat: String?
    var decimalDigits: Int?
    var symbolFirst: Bool?
    var decimalSeparator: String?
    var groupSeparator: String?
    var currencySymbol: String?
    var displaySymbol: Bool?
    
    enum CodingKeys: String , CodingKey {
        case isoCode = "iso_code"
        case exampleFormat = "example_format"
        case decimalDigits = "decimal_digits"
        case symbolFirst = "symbol_first"
        case decimalSeparator = "decimal_separator"
        case groupSeparator = "group_separator"
        case currencySymbol = "currency_symbol"
        case displaySymbol = "display_symbol"
    }
}
