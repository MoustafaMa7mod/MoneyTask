//
//  Networking.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import UIKit

class Networking: NSObject {

    static let shared = Networking()
    var request: Request?
    var accessToken = String()
    
    override init() {
        accessToken = SaveData.shared.getAccessToken()
    }
    
    func decode<T:Codable> (type:T.Type , data:Data)->T?{
        let decoder = JSONDecoder()
        do{
            let object = try decoder.decode(type.self, from: data)
            return object
        }catch{
            print("Failed in decoding: \(error)")
            return nil
        }
    }
}
