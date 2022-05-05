//
//  DetailViewController.swift
//  kursy
//
//  Created by Piotr Żakieta on 27/03/2022.
//

import UIKit
import Charts
class DetailViewController: UIViewController, NBPManagerDetailDelegate {
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewPicker: UIView!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    //Dane przesłane z poprzedniego widoku
    var sentData1:Rates!
    var sentData2:NBPModel!
    
   
    
    
    var choseFromDate: Bool?
    
    var nbpManagerDetail = NBPManagerDetail()
    var nbpDataDetail: NBPModelDetail?
    
    //przypisanie zmiennej Extra()
    var extra = Extra()


    override func viewDidLoad() {
        super.viewDidLoad()
        nbpManagerDetail.delegate = self
        nbpManagerDetail.fetchCurrency(tableName: sentData2.table, code: sentData1.code, dateFromString: sentData2.effectiveDate, dateToString: sentData2.effectiveDate)
        setValueInView()
        tableView.delegate = self
        tableView.dataSource = self
        extra.prepareactivityIndicator(sentView: view)
        //uruchomienie animacji spinera
        self.extra.activityIndicator!.startAnimating()
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
            DispatchQueue.main.async {
                if howManyDays < 0{
                    //data "od/from" nie może być większa niż data krancowa
                    self.present(self.extra.errorAlert(textError: "Data od nie może być wieksza niż data do"), animated: true, completion: nil) // jezeli błąd wywołaj alert
                }else if howManyDays > 93{ //Dokumentacja api nbp zaznacza, iz zapytanie nie moze obejmowac przedzialu dluzszego niz 93 dni, chociaz samo api pozwala na 367, przyjalem ze bezpieczniejsze bedzie przyjecia max 93 dni
                    self.present(self.extra.errorAlert(textError: "Zakres pomiedzy datami nie może być wiekszy niż 93 dni. Twój zakrest to: \(howManyDays)"), animated: true, completion: nil)
                } else{
                    self.nbpManagerDetail.fetchCurrency(tableName: self.sentData2.table, code: self.sentData1.code, dateFromString: self.fromDateTextField.text!, dateToString: self.toDateTextField.text!)
                    self.extra.activityIndicator?.startAnimating()
                }
            }
        }
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.extra.activityIndicator!.stopAnimating()
            self.updateLineChart()
        }

    }
    func didFailWithErrorDetail(error: Error) {
        DispatchQueue.main.async {
            self.present(self.extra.errorAlert(textError: "Nie można pobrać danych, sprawdz połączenie z internetem"), animated: true, completion: nil) // jezeli błąd wywołaj alert
            self.extra.activityIndicator!.stopAnimating()
            self.nbpDataDetail = nil
            self.tableView.reloadData()// wyczyszczenie table view
            
        }
    }
    //ustawienia ladowane podczas ladowania widoku
    func setValueInView(){
        titleLabel.text = sentData1.currency.capitalized
        fromDateTextField.text = sentData2.effectiveDate
        toDateTextField.text = sentData2.effectiveDate
        datePickerOutlet.maximumDate = setDateFromString(dateString: sentData2.effectiveDate)
        viewPicker.isHidden = true
        datePickerOutlet.minimumDate = setDateFromString(dateString: "2002-01-02")
    }
    
    func updateLineChart(){
        
        if let nbpDataDetail = nbpDataDetail?.rates {
            if nbpDataDetail.count < 5{
                print("mniej niz 5")
                lineChartView.isHidden = true
                lineChartView.layer.frame.size.height = 1
            }else{
                
                lineChartView.layer.frame.size.height = 300
                lineChartView.isHidden = false
                var lineChartEntry = [ChartDataEntry]()
                for i in 0..<nbpDataDetail.count{
                    let value = ChartDataEntry(x: Double(i), y: nbpDataDetail[i].mid)
                    lineChartEntry.append(value)
                }
                let lineForChart1 = LineChartDataSet(entries: lineChartEntry, label: "Wykres dla \(sentData1.currency)")
                lineForChart1.colors = [NSUIColor.blue]
                lineForChart1.drawCirclesEnabled = false
                lineForChart1.drawValuesEnabled = false
               
                
                let data = LineChartData()
                data.addDataSet(lineForChart1)
                
                lineChartView.data = data
                lineChartView.chartDescription?.text = "Wykres dla \(sentData1.currency)"
                lineChartView.backgroundColor = UIColor.white
                lineChartView.animate(xAxisDuration: 1.0)
            }
            
        }
    }
   
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowCount = nbpDataDetail?.rates.count{
            return rowCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell") as! DetailViewCell
        
        if let  rate = nbpDataDetail?.rates[indexPath.row], let code = nbpDataDetail?.code{
            cell.setDetailCell(data: rate, code: code)
        }
        
        return cell
    
    }
}
