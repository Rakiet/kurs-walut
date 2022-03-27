//
//  CurrencyCell.swift
//  kursy
//
//  Created by Piotr Żakieta on 27/03/2022.
//

import UIKit


class CurrencyCell: UITableViewCell {

    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyLabelView: UILabel!
    
    func setCurrencyCell(data: Rates){
        currencyImageView.image = UIImage(named: data.code)
        currencyLabelView.text = data.currency
        
    }
    
}
