//
//  DetailViewCell.swift
//  kursy
//
//  Created by Piotr Żakieta on 29/03/2022.
//

import UIKit

protocol DetailCellDelegate: AnyObject {
  func detailCell(_ detailCell: DetailViewCell, showCalcButtonAction dataRatesToCalc: RatesDetail)
}


class DetailViewCell: UITableViewCell {

    @IBOutlet weak var noLabelDetailViewCell: UILabel!
    @IBOutlet weak var dateLabelDetailViewCell: UILabel!
    @IBOutlet weak var midLabelDetailViewCell: UILabel!
    
    var dataRatesToCalc: RatesDetail?
    weak var delegate: DetailCellDelegate?
    
    @IBOutlet weak var calcButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            
        // Add action to perform when the button is tapped
        self.calcButton.addTarget(self, action: #selector(showCalcButtonAction(_:)), for: .touchUpInside)
      }
    
    func setDetailCell(data: RatesDetail, code: String){
        noLabelDetailViewCell.text = data.no
        dateLabelDetailViewCell.text = data.effectiveDate
        midLabelDetailViewCell.text = "1 \(code) = \(data.mid) PLN"
    }
    
    @IBAction func showCalcButtonAction(_ sender: Any) {
        if let dataRatesToCalc = dataRatesToCalc {
            if let delegate = delegate {
                delegate.detailCell(self, showCalcButtonAction: dataRatesToCalc)
                }
        }
    }
}
