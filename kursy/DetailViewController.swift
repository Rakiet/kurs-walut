//
//  DetailViewController.swift
//  kursy
//
//  Created by Piotr Żakieta on 27/03/2022.
//

import UIKit

class DetailViewController: UIViewController, NBPManagerDetailDelegate {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewPicker: UIView!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    var sentData1:Rates!
    var sentData2:String!
    var sentData3:NBPModel!
    
    var choseFromDate: Bool?
    
    var nbpManagerDetail = NBPManagerDetail()
    var nbpDataDetail: NBPModelDetail?


    override func viewDidLoad() {
        super.viewDidLoad()
        nbpManagerDetail.delegate = self
        nbpManagerDetail.fetchCurrency(tableName: sentData3.table, code: sentData1.code, dateFromString: sentData2, dateToString: sentData2)
        
        
        titleLabel.text = sentData1.currency.capitalized
        fromDateTextField.text = sentData2
        toDateTextField.text = sentData2
        viewPicker.isHidden = true
        datePickerOutlet.maximumDate = setDateFromString(dateString: sentData2)
        datePickerOutlet.minimumDate = setDateFromString(dateString: "2002-01-02")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }


    //max od do date moze wynosic 93 dni lub 367dni
    
    
    @IBAction func startEditFromDate(_ sender: Any) {
        view.endEditing(true)
        datePickerOutlet.setDate(setDateFromString(dateString: fromDateTextField.text!), animated: true)
        viewPicker.isHidden = false
        choseFromDate = true
    }
    @IBAction func startEditToDate(_ sender: Any) {
        view.endEditing(true)
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
    
    
    
    //Funckcja odpowiedzialna za zainicjowanie pobrania danych z API oraz sprawdzenie poprawności wysłanych danych
    @IBAction func showData(_ sender: Any) {
        let calendar = Calendar.current
        let fromDate = setDateFromString(dateString: fromDateTextField.text)
        let toDate = setDateFromString(dateString: toDateTextField.text)
        //Obliczenie różnicy wskazanych dat
        let components = calendar.dateComponents([.day], from: fromDate, to: toDate)
        
        if let howManyDays = components.day{
            if howManyDays < 0{
                //data "od/from" nie może być większa niż data krancowa
                print("Data od nie moze byc wieksza niz do")
            }else if howManyDays > 93{ //Dokumentacja api nbp zaznacza, iz zapytanie nie moze obejmowac przedzialu dluzszego niz 93 dni, chociaz samo api pozwala na 367, przyjalem ze bezpieczniejsze bedzie przyjecia max 93 dni
                print("Nie mamy możliwosci pokazania przedzialu dluzszego niż 93 dni")
                
            } else{
                print("Pokazemy, a co mamy nie pokazac")
                nbpManagerDetail.fetchCurrency(tableName: sentData3.table, code: sentData1.code, dateFromString: fromDateTextField.text!, dateToString: toDateTextField.text!)
            }
        }
        
        print(components.day!)
    }
    
  
    //Funkcja pobiera date w formacie string zwraca w formacie Date
    func setDateFromString(dateString: String?) -> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: dateString!)!
    }
    
    //Funkcja pobiera date w formacie Date zwraca w formacie String
    func setStringFromDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
    func didUpdateNBPDetail(nbp: NBPModelDetail) {
        nbpDataDetail = nbp
        print("!!!!!!!!!!!!!!!!!")
        for i in nbp.rates{
            print(i.mid)
            print(i.effectiveDate)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
   
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nbpDataDetail?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rate = nbpDataDetail?.rates[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell") as! DetailViewCell
    
        cell.setDetailCell(data: rate!, code: nbpDataDetail!.code)
        
        return cell
    
    }
}
