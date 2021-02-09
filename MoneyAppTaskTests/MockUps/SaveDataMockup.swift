//
//  SaveDataMockup.swift
//  MoneyAppTaskTests
//
//  Created by Mostafa Mahmoud on 2/9/21.
//

import Foundation
@testable import MoneyAppTask

class SaveDataMockup: SaveData {
    
    override func saveAccessToken(_ token: String) {
        keychain.set(token, forKey: "token")
    }
    
    override func getAccessToken() -> String {
        guard let token = keychain.get("token") else {
            return "faild to get access token"
        }
        
        return token
    }
    
}