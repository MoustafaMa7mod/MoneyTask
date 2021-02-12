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
    var parameters: [String: Any]?
    var authenticated: Bool {
        return true
    }
    
    private var authorizationHeader: String {
        return "Bearer \(self.accessToken)"
    }
    
    init(accessToken: String , method: Method , parameters: [String: Any]?) {
        self.accessToken = accessToken
        self.method = method
        self.parameters = parameters
    }
    
    
    private func configURLRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = self.method?.rawValue
        if self.method?.rawValue == "POST" || self.method?.rawValue == "PUT"  {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let body = try? JSONSerialization.data(withJSONObject: self.parameters ?? [:], options: []) else {
                fatalError("Something went wrong in parameters!")
            }
            request.httpBody = body
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
            case 200...201:
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
