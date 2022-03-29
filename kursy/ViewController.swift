//
//  ViewController.swift
//  kursy
//
//  Created by Piotr Żakieta on 24/03/2022.
//

import UIKit


class ViewController: UIViewController, NBPManagerDelegate  {
    
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var nbpManager = NBPManager()

    var nbpData: NBPModel?
    var extra = Extra()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nbpManager.delegate = self
        nbpManager.fetchCurrency(tableName: "a")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        // wywołanie fukcji odpowiedzialnej za stworzenie spinera ladowania
        extra.prepareactivityIndicator(sentView: view)
        
        self.extra.activityIndicator!.startAnimating()
        
//        nbpData = NBPModel(table: "a", no: "a", effectiveDate: "as", rates: [Rates(currency: "PL", code: "PL", mid: 2.90)])
        
    }
    

    @IBAction func segmentControlAction(_ sender: Any) {
        DispatchQueue.main.async {
            switch self.segmentControlOutlet.selectedSegmentIndex{
            case 0:
                self.extra.activityIndicator!.startAnimating()
                self.nbpManager.fetchCurrency(tableName: "a")
            case 1:
                self.extra.activityIndicator!.startAnimating()
                self.nbpManager.fetchCurrency(tableName: "b")
                
            default:
                break
            }
        }
        
    }
    
       
 
    func didUpdateNBP(nbp: NBPModel){
        
        nbpData = nbp
        print("?????????????????????????????????")
        print(nbp.table)
        for i in nbp.rates{
            print(i.mid)
            print(i.currency)
            print(i.code)
            print("===========")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.extra.activityIndicator!.stopAnimating()
        }
        
    }
    
    //fukcji odpowiedzialnej za stworzenie spinera ladowania
    
    
    
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nbpData?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rate = nbpData?.rates[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
    
        cell.setCurrencyCell(data: rate!, date: nbpData!.effectiveDate)
        
        return cell
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showDetail") {
            
            let dvc = segue.destination as! DetailViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let rate = nbpData?.rates[indexPath.row]{
                    dvc.sentData1 = rate as Rates
                    dvc.sentData2 = (nbpData?.effectiveDate)! as String
                    dvc.sentData3 = nbpData! as NBPModel
                }
                
            }
            
        }
        
        
        
    }
    
    
}

