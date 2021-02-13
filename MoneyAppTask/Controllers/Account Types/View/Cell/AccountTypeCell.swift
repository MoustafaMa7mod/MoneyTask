//
//  AccountTypeCell.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import UIKit

class AccountTypeCell: UITableViewCell {

    @IBOutlet weak var accountTypeText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ type: String){
        accountTypeText.text = type
    }

    
}
