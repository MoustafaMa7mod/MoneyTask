//
//  AddAccountViewModel.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import UIKit

class AddAccountViewModel: NSObject {
    var accountType = ["Checking" , "Savings" , "Cash" , "Credit Card" , "Line of Credit"]
    var selectedIndex = 0

    
    
    func getAccountTypeCount() -> Int{
        return accountType.count
    }
    
    func getAccountTypeItem(_ index: Int) -> String{
        return accountType[index]
    }

}
