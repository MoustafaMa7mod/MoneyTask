//
//  AccountTypesViewModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import UIKit

class AccountTypesViewModel: NSObject {
    
    var accountTypeSection = ["Budget" , "Tracking"]
    var accountTypeBubgetSection = Array (["Checking" : "checking" , "Savings" :"savings"  , "Cash":"cash" , "Credit Card":"creditCard" , "Line of Credit":"lineOfCredit"])
    var accountTypeTrackingSection = Array(["Asset (e.g Investment)": "otherAsset" , "Liability (e.g Motgage)": "otherLiability"])
    var accountTypeForServerValue = String()

    func getNumberOfsection() -> Int{
        return accountTypeSection.count
    }
    func getSectionTitleHeader(_ index: Int) -> String{
        return accountTypeSection[index]
    }
    
    func getCountOfEachSection(_ section: Int) -> Int{
        if section == 0 {
            return accountTypeBubgetSection.count
        }else{
            return accountTypeTrackingSection.count
        }
    }

    func getItemOfEachSection( _ section: Int ,  _ index: Int) -> (key: String, value: String){
        if section == 0 {
            return accountTypeBubgetSection[index]
        }else{
            return accountTypeTrackingSection[index]
        }
    }
}
