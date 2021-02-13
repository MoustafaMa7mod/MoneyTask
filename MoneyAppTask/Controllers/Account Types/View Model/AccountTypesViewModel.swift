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
    
    func getCountOfBudgetSection() -> Int{
        return accountTypeBubgetSection.count
    }
    
    func getCountOfTrackingSection() -> Int{
        return accountTypeTrackingSection.count
    }
    
    
    
    
    func getItemOfBudgetSection(_ index: Int) -> String{
        return accountTypeBubgetSection[index].key
    }
    func getItemOfTrackingSection(_ index: Int) -> String{
        return accountTypeTrackingSection[index].key
    }
    
    func getItemOfBudgetSectionValue(_ index: Int) -> String{
        return accountTypeBubgetSection[index].value
    }
    func getItemOfTrackingSectionValue(_ index: Int) -> String{
        return accountTypeTrackingSection[index].value
    }

    
    
    func getSectionTitleHeader(_ index: Int) -> String{
        return accountTypeSection[index]
    }

    
    
}
