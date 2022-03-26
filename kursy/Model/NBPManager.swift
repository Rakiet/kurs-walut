//
//  NBPManager.swift
//  kursy
//
//  Created by Piotr Żakieta on 26/03/2022.
//

import Foundation

struct NBPManager{
    let NBPURL = "https://api.nbp.pl/api/exchangerates/tables"
    
    func fetchCurrency(tableName:String){
        let ulrString = "\(NBPURL)/\(tableName)"
        performRequest(urlString: ulrString)
        
    }
    
    func performRequest(urlString: String){
        //Create URL
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            
            //Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            //Start task
            task.resume()
            
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil{
            print(error!)
            return
        }
        
        if let safeDate = data {
            let dataString = String(data: safeDate, encoding: .utf8)
            print(dataString)
        }
        
    }
}
