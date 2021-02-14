//
//  ViewController.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/9/21.
//

import UIKit
import AuthenticationServices


class AuthenticationViewController: UIViewController {

    // MARK:- variables
    private var authSession: ASWebAuthenticationSession?
    private var saveData = SaveData.shared

    
    private lazy var authUrl: URL = {
        let clientId = URLQueryItem(name: "client_id", value: Contants.clientAuthID.rawValue)
        let redirectURI = URLQueryItem(name: "redirect_uri", value: Contants.redirectURL.rawValue)
        let responseType = URLQueryItem(name: "response_type", value: "token")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "app.youneedabudget.com"
        urlComponents.path = "/oauth/authorize"
        urlComponents.queryItems = [clientId, redirectURI, responseType]
        
        return urlComponents.url!
    }()
    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
    }
    
    public init(saveData: SaveData) {
        self.saveData = saveData
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
    }
    
    // MARK:- get data login (access token) from YNAB Website
    private func oAuthLogin(completion: @escaping (String?, Error?) -> Void) {
        self.authSession?.cancel()
        self.authSession = ASWebAuthenticationSession(url: self.authUrl, callbackURLScheme: Contants.urlScheme.rawValue) {
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
        }
        self.authSession?.start()
    }
    
    // MARK:- convert url to access token
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
    @IBAction func rigesterButtonTapped(_ sender: Any) {
        let isNetworkAviaible = Networking.isConnectedToInternet
        guard isNetworkAviaible == true else {
            self.showErrorAlert("Alert Internet Error", "no internet connection!")
            return
        }
        
        oAuthLogin { [weak self] (oAuthToken: String?, error: Error?) in
            
            if let token = oAuthToken {
                self?.saveData.saveAccessToken(token)
                self?.gotobudgetsPage()
                return
            }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self?.showErrorAlert("Alert Error", error.localizedDescription)
            } else {
                print("Unknown error")
                self?.showErrorAlert("Alert Error", "Unknown error")

            }
        }
    }
    
    private func gotobudgetsPage() {
        let budgetsViewController = BudgetsViewController.instantiateViewController()
        budgetsViewController.modalPresentationStyle = .fullScreen
        budgetsViewController.modalTransitionStyle = .crossDissolve
        let nav = MoneyAppNavigationController(rootViewController: budgetsViewController)
        UIApplication.shared.keyWindow?.rootViewController = nav

    }
}

extension AuthenticationViewController: ASWebAuthenticationPresentationContextProviding {
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
