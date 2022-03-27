//
//  ViewController.swift
//  kursy
//
//  Created by Piotr Żakieta on 24/03/2022.
//

import UIKit

class ViewController: UIViewController, NBPManagerDelegate  {
    
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    var nbpManager = NBPManager()

    var nbpData: NBPModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //test URLSession
        nbpManager.delegate = self
        nbpManager.fetchCurrency(tableName: "a")
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
   
    

    @IBAction func segmentControlAction(_ sender: Any) {
        switch segmentControlOutlet.selectedSegmentIndex{
        case 0:
            nbpManager.fetchCurrency(tableName: "a")
        case 1:
            nbpManager.fetchCurrency(tableName: "b")
            
        default:
            break
        }
    }
    
       
 
    func didUpdateNBP(nbp: NBPModel){
        nbpData = nbp
        print("?????????????????????????????????")
        print(nbp.table)
        for i in nbp.rates{
            print(i.mid)
            print(i.currency)
            print("===========")
        }
    }
}

