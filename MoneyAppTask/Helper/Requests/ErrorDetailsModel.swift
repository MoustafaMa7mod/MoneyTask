//
//  ErrorDetails.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/14/21.
//

import Foundation

struct ErrorDetailsModel: Codable {
    var error: ErrorDetailsObject?
}



struct ErrorDetailsObject: Codable {
    var id: String?
    var name: String?
    var detail: String?
    
    init(id: String?, name: String?, detail: String?) {
        self.id = id
        self.name = name
        self.detail = detail
    }
}
