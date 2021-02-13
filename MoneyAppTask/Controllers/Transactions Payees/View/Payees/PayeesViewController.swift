//
//  c.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import UIKit

class PayeesViewController: UIViewController {

    // MARK:- outlets
    @IBOutlet weak var payessTableView: UITableView!
    
    // MARK:- varaibles
    var budgetObject: BudgetObject?
    var payeesViewModel: PayeesViewModel?

    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if let budgetObject =  budgetObject {
            payeesViewModel = PayeesViewModel(budgetObject: budgetObject)
        }
        setupNavBar()
        setupTableView()
        getData()
    }
    
    class func instantiateViewController() -> PayeesViewController  {
        return UIStoryboard(name: "TransactionPayees", bundle: nil).instantiateViewController(withIdentifier:  String(describing: PayeesViewController.self)) as! PayeesViewController
    }
    
    // MARK:- setup setting of navigation controller
    private func setupNavBar(){
        title = "Payess"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

    }
    
    // MARK: - actions


    // MARK:- setup setting of table view
    private func setupTableView(){
        payessTableView.registerCellNib(cellClass: PayeesCell.self)
        payessTableView.delegate = self
        payessTableView.dataSource = self
        payessTableView.tableFooterView = UIView()

    }
    
    // MARK:- get data from server
    private func getData(){
        payeesViewModel?.getData(completion: { [weak self] loadData ,message in
            if loadData {
                DispatchQueue.main.async {
                    self?.payessTableView.reloadData()
                }
            }else{
                print(message ?? "")
            }
        })
    }

    

}
