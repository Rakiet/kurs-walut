//
//  DetailViewCell.swift
//  kursy
//
//  Created by Piotr Żakieta on 29/03/2022.
//

import UIKit

class DetailViewCell: UITableViewCell {

    @IBOutlet weak var noLabelDetailViewCell: UILabel!
    @IBOutlet weak var dateLabelDetailViewCell: UILabel!
    @IBOutlet weak var midLabelDetailViewCell: UILabel!
    
    func setDetailCell(data: RatesDetail, code: String){
        noLabelDetailViewCell.text = data.no
        dateLabelDetailViewCell.text = data.effectiveDate
        midLabelDetailViewCell.text = "1 \(code) = \(data.mid) PLN"
    }
    

    
}
