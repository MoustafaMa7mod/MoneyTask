//
//  AccountCell.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/12/21.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountType: UILabel!
    @IBOutlet weak var clearedBalance: UILabel!
    @IBOutlet weak var unclearedBalance: UILabel!
    @IBOutlet weak var workingBalance: UILabel!
    @IBOutlet weak var note: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func configCell(_ data: AccountObject , _ currency: String){
        accountName.text = data.name
        accountType.text = data.type
        clearedBalance.text = "\(currency)\(String(describing: data.clearedBalance ?? 0))"
        unclearedBalance.text = "\(currency)\(String(describing: data.unclearedBalance ?? 0))"
        workingBalance.text = "\(currency)\(String(describing: data.balance ?? 0))"
        note.text = data.note
    }
    
}
