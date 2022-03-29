//
//  NBPManager.swift
//  kursy
//
//  Created by Piotr Żakieta on 26/03/2022.
//

import Foundation

protocol NBPManagerDelegate {
    func didUpdateNBP(nbp: NBPModel)
    func didFailWithError(error: Error)
}

struct NBPManager{
    let NBPURL = "https://api.nbp.pl/api/exchangerates/tables"
    
    var delegate: NBPManagerDelegate?
    
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
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeDate = data {
                    if let nbp = self.parseJSON(nbpData: safeDate){
                        self.delegate?.didUpdateNBP(nbp: nbp)
                    }
                }
            }
            task.resume()
            
            
            
            
            
        }
    }
    
    func parseJSON(nbpData: Data) -> NBPModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([NBPData].self, from: nbpData)
            

            let table = decodedData[0].table
            let no = decodedData[0].no
            let effectiveDate = decodedData[0].effectiveDate
            let rates = decodedData[0].rates

            let nbp = NBPModel(table: table, no: no, effectiveDate: effectiveDate, rates: rates)
            return nbp
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
