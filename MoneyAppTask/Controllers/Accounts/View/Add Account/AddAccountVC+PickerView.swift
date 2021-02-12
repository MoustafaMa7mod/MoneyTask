//
//  AddAccountVC+PickerView.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import Foundation
import UIKit


extension AddAccountViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addAccountViewModel?.getAccountTypeCount() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addAccountViewModel?.getAccountTypeItem(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        addAccountViewModel?.selectedIndex = row
    }
    
    @objc func showTypeOfAccunt(){
        addAccountViewModel?.accountTypeForServerValue = addAccountViewModel?.accountTypeForServerArray[addAccountViewModel?.selectedIndex ?? 0] ?? ""
        accountTypeTextField.text = addAccountViewModel?.getAccountTypeItem(addAccountViewModel?.selectedIndex ?? 0)
        self.view.endEditing(true)
    }

    
    
}
