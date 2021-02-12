//
//  Request.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import UIKit

enum Method: String{
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}


class Request: NSObject {
    private(set) var accessToken: String
    var method: Method?
    var body: Data?
    var authenticated: Bool {
        return true
    }
    
    private var authorizationHeader: String {
        return "Bearer \(self.accessToken)"
    }
    
    init(accessToken: String , method: Method , body: Data?) {
        self.accessToken = accessToken
        self.method = method
        self.body = body
    }
    
    
    private func configURLRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = self.method?.rawValue
        if self.method?.rawValue == "POST" || self.method?.rawValue == "PUT"  {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = self.body
        }
        if (self.authenticated) {
            request.setValue(self.authorizationHeader, forHTTPHeaderField: "Authorization")
        }
        
        print(request)
        
        return request
    }
    
    func request(_ url: URL, completion: @escaping (Data?, String?) -> Void) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: configURLRequest(url)) { data, response, error in
            
            guard error == nil , let response = response as? HTTPURLResponse else {
                completion(nil , error?.localizedDescription ?? "Something went wrong!" )
                return
            }
            print(response.statusCode)
            switch response.statusCode {
            case 200:
                guard let data = data else {return}
                completion(data , nil)
            case 401:
                completion(nil , error?.localizedDescription ?? "unauthorized")
            default:
                completion(nil  , error?.localizedDescription ?? "Something went wrong!")
                break
            }

        }
        
        task.resume()
    }
    
    
    
}
