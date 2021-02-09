//
//  SaveData.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/9/21.
//

import UIKit
import KeychainSwift

class SaveData: NSObject {
    
    static let shared = SaveData()
    let keychain = KeychainSwift()
    
    func saveAccessToken(_ token: String){
        keychain.set(token, forKey: "token")
    }
    
    func getAccessToken() -> String{
        guard let token = keychain.get("token") else {
            return "faild to get access token"
        }
        
        return token
    }
    
}
