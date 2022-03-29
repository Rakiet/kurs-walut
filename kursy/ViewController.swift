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
    
    //przypisanie do zmiennej NBPManager
    var nbpManager = NBPManager()

    //zmienna przechowujace dane pobrane z api
    var nbpData: NBPModel?
    
    //przypisanie zmiennej Extra()
    var extra = Extra()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nbpManager.delegate = self
        nbpManager.fetchCurrency(tableName: "a")
        tableView.delegate = self
        tableView.dataSource = self
        
        // wywołanie fukcji odpowiedzialnej za stworzenie spinera ladowania
        extra.prepareactivityIndicator(sentView: view)
        //uruchomienie animacji spinera
        self.extra.activityIndicator!.startAnimating()
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
        
            
            DispatchQueue.main.async {
                self.nbpData = nbp
                self.tableView.reloadData()
                self.extra.activityIndicator!.stopAnimating()
            }
    }
    
    func didFailWithError(error: Error) {
        print(error)
        print("!!!!!!!!!!!!!!!!!!!!!!")
        DispatchQueue.main.async {
            self.present(self.extra.errorConnection(), animated: true, completion: nil)
            self.extra.activityIndicator!.stopAnimating()
            self.nbpData = nil
            self.tableView.reloadData()
            
        }
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let ratesCount = nbpData?.rates.count{
            return ratesCount
        }else{
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        if let rate = nbpData?.rates[indexPath.row]{
        
    
        cell.setCurrencyCell(data: rate, date: nbpData!.effectiveDate)
        
        
        }
        
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

