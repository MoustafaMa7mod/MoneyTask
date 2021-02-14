//
//  PayeeTransactionsCell.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/14/21.
//

import UIKit

class PayeeTransactionsCell: UITableViewCell {

    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var payeeName: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var dateTextField: UILabel!
    @IBOutlet weak var amountTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ data: PayeeTransactionsObject , _ currency: String){
        accountName.text = data.accountName
        payeeName.text = data.payeeName
        categoryName.text = data.categoryName
        dateTextField.text = data.date
        amountTextField.text = "\(currency)\(data.amount ?? 0)"
    }


}
