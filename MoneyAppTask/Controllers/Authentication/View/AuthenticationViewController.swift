//
//  ViewController.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/9/21.
//

import UIKit
import AuthenticationServices




class AuthenticationViewController: UIViewController {

    fileprivate let clientAuthID = "dba4b95f6bbb9e22efe5e4f412ca98380131a200217c056c88a877768e1d0831"
    fileprivate let redirectURL = "moneyapptask://oauth"
    fileprivate let urlScheme = "moneyapptask://"

    private var authSession: ASWebAuthenticationSession?

    private lazy var authUrl: URL = {
        let clientId = URLQueryItem(name: "client_id", value: clientAuthID)
        let redirectURI = URLQueryItem(name: "redirect_uri", value: redirectURL)
        let responseType = URLQueryItem(name: "response_type", value: "token")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "app.youneedabudget.com"
        urlComponents.path = "/oauth/authorize"
        urlComponents.queryItems = [clientId, redirectURI, responseType]
        
        return urlComponents.url!
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func oAuthLogin(completion: @escaping (String?, Error?) -> Void) {
        self.authSession?.cancel()
        self.authSession = ASWebAuthenticationSession(url: self.authUrl, callbackURLScheme: urlScheme) {
            (url: URL?, error: Error?) in
            
            guard let url = url else {
                completion(nil, error)
                return
            }
            
            if let token = self.accessToken(from: url) {
                completion(token, nil)
            }
        }
        if #available(iOS 13.0, *) {
            self.authSession?.presentationContextProvider = self
        } else {
            // No need for a presentation context in previous versions of iOS
        }
        self.authSession?.start()
    }
    
    private func accessToken(from url: URL) -> String? {
        guard let fragment = url.fragment else {
            return nil
        }
        
        let fragmentComponents = fragment.split(separator: "&")
        for keyValuePairs in fragmentComponents {
            let keyValuePair = keyValuePairs.split(separator: "=")
            
            if keyValuePair.contains("access_token") {
                if let value = keyValuePair.last {
                    return String(value)
                }
            }
        }
        
        return nil
    }
    
    // MARK - Actions
    @IBAction func oAuthLoginButtonTapped(_ sender: Any) {
        oAuthLogin {
            (oAuthToken: String?, error: Error?) in
            
            if let token = oAuthToken {
                print("OAuth token received from redirect: \(token)")
                return
            }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Unknown error")
            }
        }
    }


}

extension AuthenticationViewController: ASWebAuthenticationPresentationContextProviding {
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
