//
//  CurrenciesTableViewCell.swift
//  TaskAnusha
//
//  Created by Mouritech on 19/07/20.
//  Copyright © 2020 Mouritech. All rights reserved.
//

import UIKit

class CurrenciesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCurrencyType: UILabel!
    @IBOutlet weak var lblCurrencyMoney: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
