//
//  PayeesCell.swift
//  MoneyAppTask
//
//  Created by Mostafa Mahmoud on 2/13/21.
//

import UIKit

class PayeesCell: UITableViewCell {

    @IBOutlet weak var payeesName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configCell(_ data: PayeesObject){
        payeesName.text = data.name
    }

    
}
