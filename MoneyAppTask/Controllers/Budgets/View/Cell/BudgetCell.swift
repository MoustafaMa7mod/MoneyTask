//
//  BudgetCell.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/10/21.
//

import UIKit

class BudgetCell: UITableViewCell {

    @IBOutlet weak var budgetName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(_ data: BudgetObject){
        budgetName.text = data.name
    }

  
    
}
