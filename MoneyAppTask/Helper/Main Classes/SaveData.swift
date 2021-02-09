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
    let keyChain = KeychainSwift()
    
    func saveAccessToken(_ token: String){
        keyChain.synchronizable = true
        keyChain.set(token, forKey: "token")
    }
    
    func getAccessToken() -> String{
        keyChain.synchronizable = true
        guard let token = keyChain.get("token") else {
            return "faild to get access token"
        }
        
        return token
    }
    
}
