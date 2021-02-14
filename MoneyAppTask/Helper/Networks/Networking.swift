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
    let reachability = Reachability()!
    static var isConnectedToInternet:Bool?

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
    
    @objc func checkInternetConnection(){
        reachability.whenReachable = { reachability in
            Networking.isConnectedToInternet = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "internet"), object: self, userInfo: ["isConnected": true])
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("[network] Not reachable")
            Networking.isConnectedToInternet = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "internet"), object: self, userInfo: ["isConnected": false])
            print("not internet")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    
}
