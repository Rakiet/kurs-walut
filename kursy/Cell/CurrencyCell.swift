//
//  CurrencyCell.swift
//  kursy
//
//  Created by Piotr Żakieta on 27/03/2022.
//

import UIKit


class CurrencyCell: UITableViewCell {

    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyCodeLabelView: UILabel!
    @IBOutlet weak var currencyDateLabelView: UILabel!
    @IBOutlet weak var currencyNameLabelView: UILabel!
    @IBOutlet weak var currencyValueLabelView: UILabel!
    
    //funkcja odpowiedzialna za przekazanie widokowi zmiennych do wyswietlenia
    func setCurrencyCell(data: Rates, date: String){
        currencyImageView.image = UIImage(named: data.code)
        currencyCodeLabelView.text = data.code
        currencyDateLabelView.text = date
        currencyNameLabelView.text = data.currency.capitalized
        currencyValueLabelView.text = "1 \(data.code) = \(data.mid) PLN"
        
    }
    
}
