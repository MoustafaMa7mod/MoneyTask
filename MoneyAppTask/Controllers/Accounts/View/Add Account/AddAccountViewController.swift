//
//  AddAccountViewController.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import UIKit
import RxSwift
import RxCocoa

class AddAccountViewController: UIViewController {
 
    // MARK:- outlets
    @IBOutlet weak var accountNameTextField: UITextField!
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var accountTypeTextField: UITextField!
    
    // MARK:- varaibles
    var budgetObject: BudgetObject?
    var accountTypesPickerView: UIPickerView = UIPickerView()
    var addAccountViewModel: AddAccountViewModel?
    var disposed = DisposeBag()
    var paaData:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let budgetObject =  budgetObject {
            addAccountViewModel = AddAccountViewModel(budgetObject: budgetObject)
        }
        setupNavBar()
        accountTypeTextField.addTarget(self, action: #selector(gotoAccountTypePage), for: .touchDown)
        bindData()
    }
    
    
    
    private func bindData(){
        guard let addAccountViewModel = addAccountViewModel else {
            return
        }
        configure(with: addAccountViewModel)
        addAccountViewModel.reloadView = { [weak self] in
            self?.accountNameTextField.text = self?.addAccountViewModel?.accountTypeName.value
            self?.balanceTextField.text = self?.addAccountViewModel?.accountBalance.value
            self?.accountTypeTextField.text = self?.addAccountViewModel?.accountTypeValue.value
           
        }
    }
    
    func configure(with viewModel: AddAccountViewModel) {
        guard let addAccountViewModel = addAccountViewModel else {
            return
        }
        accountNameTextField.rx.text.map { $0 ?? "" }.bind(to: addAccountViewModel.accountTypeName).disposed(by: disposed)
        balanceTextField.rx.text.map { $0 ?? "" }.bind(to: addAccountViewModel.accountBalance).disposed(by: disposed)
        
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
    
    // MARK:- Actions
    @objc func backToAccountList(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func gotoAccountTypePage(textField: UITextField) {
        let addAccountViewController = AccountTypesViewController.instantiateViewController()
        addAccountViewController.passData = { [weak self] accountTypeKey , accountTypeValue in
            self?.accountTypeTextField.text = accountTypeKey
            self?.addAccountViewModel?.accountType = accountTypeValue
        }
        let nav = MoneyAppNavigationController(rootViewController: addAccountViewController)
        self.present(nav , animated: true)
    }
    
    @IBAction func saveNewAccount(_ sender: Any) {
        LoadingIndicatorView.show("Loading")

        guard let paramter = addAccountViewModel?.parseDataFromView() else {return}
        addAccountViewModel?.addAccountData(withParamter: paramter , Andcompletion: { [weak self] loadData, error in
            DispatchQueue.main.async {
                LoadingIndicatorView.hide()
            }
            if loadData {
                DispatchQueue.main.async {
                    self?.paaData?()
                    self?.dismiss(animated: true, completion: nil)
                }

            }else{
                DispatchQueue.main.async {
                    self?.showErrorAlert("Alert \(error?.name ?? "")", error?.detail ?? "")
                }
            }
        })
    }
}
