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
    var parameters: [String : [String : Any]]?
    private let session: URLSessionProtocol

    var authenticated: Bool {
        return true
    }
    
    private var authorizationHeader: String {
        return "Bearer \(self.accessToken)"
    }
    
    init(accessToken: String , method: Method , parameters: [String : [String : Any]]? , session: URLSessionProtocol) {
        self.accessToken = accessToken
        self.method = method
        self.parameters = parameters
        self.session = session

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
                
        return request
    }
    
    func request(_ url: URL, completion: @escaping (Data?, ErrorDetailsObject?) -> Void) {
        let isNetworkAviaible = Networking.isConnectedToInternet
        guard isNetworkAviaible == true else {
            completion(nil , ErrorDetailsObject(id: "001", name: "Internet Error", detail: "no internet connection!") )
            return
        }

        let task = session.dataTask(with: configURLRequest(url)) { data, response, error in
            guard error == nil , let response = response as? HTTPURLResponse else {
                completion(nil , ErrorDetailsObject(id: "000", name: "Unknown", detail: "Something went wrong!") )
                return
            }
            guard let data = data else {return}
            switch response.statusCode {
            case 200...299:
                completion(data , nil)
            case 400...499:
                let errorModel = Networking.shared.decode(type: ErrorDetailsModel.self, data: data)
                completion(nil , errorModel?.error)
            default:
                completion(nil  , ErrorDetailsObject(id: "000", name: "Unknown", detail: "Something went wrong!"))
                break
            }

        }
        task.resume()
    }
}
