//
//  CurrencyCell.swift
//  kursy
//
//  Created by Piotr Żakieta on 27/03/2022.
//

import UIKit


class CurrencyCell: UITableViewCell {

    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyDateLabelView: UILabel!
    @IBOutlet weak var currencyNameLabelView: UILabel!
    @IBOutlet weak var currencyValueLabelView: UILabel!
    
    var dataRatesToCalc: Rates?
    weak var delegate: CurrencyCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            
        // Add action to perform when the button is tapped
        self.calcButton.addTarget(self, action: #selector(calcButtonTapped(_:)), for: .touchUpInside)
      }
    
    //funkcja odpowiedzialna za przekazanie widokowi zmiennych do wyswietlenia
    func setCurrencyCell(data: Rates, date: String){
        currencyImageView.image = UIImage(named: data.code)
        currencyDateLabelView.text = date
        currencyNameLabelView.text = data.currency.capitalized
        currencyValueLabelView.text = "1 \(data.code) = \(data.mid) PLN"
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
      }
    
    @IBAction func calcButtonTapped(_ sender: Any) {
        if let dataRatesToCalc = dataRatesToCalc {
            if let delegate = delegate {
                    delegate.currencyCell(self, calcButtonTapped: dataRatesToCalc)
                }
        }
        
    }
    
    
}

protocol CurrencyCellDelegate: AnyObject {
  func currencyCell(_ currencyCell: CurrencyCell, calcButtonTapped dataRatesToCalc: Rates)
}
