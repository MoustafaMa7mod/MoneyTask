//
//  AuthenticationTests.swift
//  MoneyAppTaskTests
//
//  Created by Mostafa Mahmoud on 2/9/21.
//

import XCTest
@testable import MoneyAppTask

class AuthenticationTests: XCTestCase {
    
    var authenticationViewController: AuthenticationViewController?
    var saveDataMockup: SaveDataMockup!

    override func setUpWithError() throws {
        saveDataMockup = SaveDataMockup()
        authenticationViewController = AuthenticationViewController(saveData: saveDataMockup)
    }
    
    override func tearDownWithError() throws {
        authenticationViewController = nil
    }

    
    func test_access_token_not_nil() {
        let url = "moneyapptask://oauth#access_token=1234&token_type=Bearer&expires_in=7200"
        
        let fragmentComponents = url.split(separator: "&")
        for keyValuePairs in fragmentComponents {
            let keyValuePair = keyValuePairs.split(separator: "=")
            
            if keyValuePair.contains("access_token") {
                if let value = keyValuePair.last {
                    XCTAssertNotNil(value)
                }
            }
        }
        
    }
    
    
    func test_save_access_token_in_key_chain(){
        saveDataMockup.saveAccessToken("1234")
    }
    
    func test_get_access_token_from_key_chain(){
        XCTAssertNotNil(saveDataMockup.getAccessToken())
    }
    
    func test_access_token_save_successfully(){
        XCTAssertEqual(saveDataMockup.getAccessToken(), "1234")
        XCTAssertNotEqual(saveDataMockup.getAccessToken(), "faild to get access token")

    }
    
    
    
    
}

