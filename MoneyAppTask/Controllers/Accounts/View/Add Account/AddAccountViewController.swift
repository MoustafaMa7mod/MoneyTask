//
//  AddAccountViewController.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import UIKit

class AddAccountViewController: UIViewController {
 
    // MARK:- outlets
    @IBOutlet weak var accountNameTextField: UITextField!
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var accountTypeTextField: UITextField!
    
    // MARK:- varaibles
    var budgetObject: BudgetObject?
    var accountTypesPickerView: UIPickerView = UIPickerView()
    var addAccountViewModel: AddAccountViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let budgetObject =  budgetObject {
            addAccountViewModel = AddAccountViewModel(budgetObject: budgetObject)
        }

        setupNavBar()
        setupPickerView()
    }

    class func instantiateViewController() -> AddAccountViewController  {
        return UIStoryboard(name: "Accounts", bundle: nil).instantiateViewController(withIdentifier:  String(describing: AddAccountViewController.self)) as! AddAccountViewController
    }
    
    // MARK:- setup setting of navigation controller
    private func setupNavBar(){
        title = "Add Account"
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(backToAccountList))
        navigationItem.leftBarButtonItem = cancel
    }
    
    // MARK:- setup setting of picker view
    private func setupPickerView(){
        accountTypesPickerView.delegate = self
        accountTypesPickerView.dataSource = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(showTypeOfAccunt))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton , doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true

        accountTypeTextField.inputView = accountTypesPickerView
        accountTypeTextField.inputAccessoryView = toolBar

    }
    // MARK:- Actions
    @objc func backToAccountList(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveNewAccount(_ sender: Any) {
        
        let object = ["account": ["name": self.accountNameTextField.text ?? "" , "type": addAccountViewModel?.accountTypeForServerValue ?? "" ,"balance": Int(balanceTextField.text ?? "0")  ?? 0]]
        
        addAccountViewModel?.addAccountData(withParamter: object , Andcompletion: { loadData, message in
            if loadData {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }else{
                print(message ?? "")
            }
        })
    }
}
