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
        let ulrString = "\(NBPURL)/\(tableName)/?format=json"
        performRequest(urlString: ulrString)
        
    }
    
    func performRequest(urlString: String){
        //Create URL
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            
            //Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeDate = data {
//                    let dataString = String(data: safeDate, encoding: .utf8)
//                    print(dataString)
                    
                    self.parseJSON(nbpData: safeDate)
                }
            }
            
            //Start task
            task.resume()
            
        }
    }
    
    func parseJSON(nbpData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([NBPData].self, from: nbpData)
            
        }catch{
            print(error)
        }
    }
    
}
