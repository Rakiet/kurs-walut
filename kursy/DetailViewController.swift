//
//  DetailViewController.swift
//  kursy
//
//  Created by Piotr Żakieta on 27/03/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewPicker: UIView!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    var sentData1:Rates!
    var sentData2:String!
    
    var choseFromDate: Bool?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = sentData1.currency.capitalized
        fromDateTextField.text = sentData2
        toDateTextField.text = sentData2
        viewPicker.isHidden = true
        datePickerOutlet.maximumDate = setDateFromString(dateString: sentData2)
        datePickerOutlet.minimumDate = setDateFromString(dateString: "2002-01-02")
    }


    //max od do date moze wynosic 93 dni lub 367dni
    
    
    @IBAction func startEditFromDate(_ sender: Any) {
        datePickerOutlet.setDate(setDateFromString(dateString: fromDateTextField.text!), animated: true)
        viewPicker.isHidden = false
        choseFromDate = true
    }
    @IBAction func startEditToDate(_ sender: Any) {
        datePickerOutlet.setDate(setDateFromString(dateString: toDateTextField.text!), animated: true)
        viewPicker.isHidden = false
        choseFromDate = false
    }
    
    
    @IBAction func setDateInTextField(_ sender: Any) {
        if let choseFrom = choseFromDate{
            if choseFrom{
                fromDateTextField.text = setStringFromDate(date: datePickerOutlet.date)
            }else{
                toDateTextField.text = setStringFromDate(date: datePickerOutlet.date)
            }
        }
        viewPicker.isHidden = true
    }
    
    @IBAction func showData(_ sender: Any) {
        let calendar = Calendar.current
        
        let fromDate = setDateFromString(dateString: fromDateTextField.text)
        let toDate = setDateFromString(dateString: toDateTextField.text)
        
        let components = calendar.dateComponents([.day], from: fromDate, to: toDate)
        
        print(components.day!)
    }
    
  
    
    func setDateFromString(dateString: String?) -> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: dateString!)!
    }
    
    func setStringFromDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
}
