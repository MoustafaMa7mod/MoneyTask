//
//  PayeesModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import Foundation


struct PayeesModel: Codable {
    var data: Payees?
}


struct Payees: Codable {
    var payees: [PayeesObject]?
}


struct PayeesObject: Codable {
    var id: String?
    var name: String?
    var transferAccountId: String?
    var deleted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id , name, deleted
        case transferAccountId = "transfer_account_id"
    }

    
}
