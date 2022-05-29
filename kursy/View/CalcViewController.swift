//
//  CalcViewController.swift
//  kursy
//
//  Created by Piotr Żakieta on 06/05/2022.
//

import UIKit

class CalcViewController: UIViewController {

    @IBOutlet weak var calcView: UIView!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var enterTextField: UITextField!
    @IBOutlet weak var labelNextToTextField: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var codeValueNextToResult: UILabel!
    
    @IBOutlet weak var calcButtonOutlet: UIButton!
    
    
    
    
    
    var sentData1:Rates!
    
    
    var isCurrencyChange = false
    
    var dataToPrepareCalcView: Rates?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadAllData()
    }
    
    func loadAllData(){
        if let sentData = sentData1{
            enterTextField.text = "1"
            labelNextToTextField.text = "PLN"
            isCurrencyChange = false
            resultLabel.text = String(sentData.mid)
            codeValueNextToResult.text = String(sentData.code)
            calcView.layer.cornerRadius = 40
        }
    }
    
    
    @IBAction func currencyChangeAction(_ sender: Any) {
        if let firstValue = enterTextField.text, let secondValue = resultLabel.text{
            if isCurrencyChange{
                isCurrencyChange = false
                labelNextToTextField.text = "PLN"
                codeValueNextToResult.text = sentData1.code
                
                resultLabel.text = firstValue
                enterTextField.text = secondValue
            }else{
                isCurrencyChange = true
                labelNextToTextField.text = sentData1.code
                codeValueNextToResult.text = "PLN"
                
                resultLabel.text = firstValue
                enterTextField.text = secondValue
            }
        }
    }
    
    @IBAction func calcButtonAction(_ sender: Any) {
        calculateValue()
    }
    
    func calculateValue(){
        if let firstDoubleValue = Double(enterTextField.text!), let sentData = sentData1{
            if isCurrencyChange{
                let calculate = firstDoubleValue * sentData.mid
                
                resultLabel.text = String(round(calculate*100)/100)
            }else{
                let calculate = firstDoubleValue * sentData.mid
                resultLabel.text = String(round(calculate*100)/100)
                
            }
        }
        
    }
    
    

}

