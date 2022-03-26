//
//  NBPManager.swift
//  kursy
//
//  Created by Piotr Żakieta on 26/03/2022.
//

import Foundation

struct NBPManager{
    let NBPURL = "http://api.nbp.pl/api/exchangerates/tables"
    
    func fetchCurrency(tableName:String){
        let ulrString = "\(NBPURL)/\(tableName)"
        
    }
}
