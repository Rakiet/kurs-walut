//
//  ViewController.swift
//  kursy
//
//  Created by Piotr Żakieta on 24/03/2022.
//

import UIKit

class ViewController: UIViewController, NBPManagerDelegate {
    
    var nbpManager = NBPManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        //test URLSession
        nbpManager.delegate = self
        nbpManager.fetchCurrency(tableName: "a")
        
        // Do any additional setup after loading the view.
    }

    func didUpdateNBP(nbp: NBPModel){
        print(nbp.table)
    }
}

