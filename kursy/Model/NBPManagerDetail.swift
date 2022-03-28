//
//  NBPManagerDetail.swift
//  kursy
//
//  Created by Piotr Żakieta on 28/03/2022.
//


import Foundation

protocol NBPManagerDetailDelegate {
    func didUpdateNBPDetail(nbp: NBPModelDetail)
}

struct NBPManagerDetail{
    let NBPURLDetail = "https://api.nbp.pl/api/exchangerates/rates"
    //https://api.nbp.pl/api/exchangerates/rates/a/gbp/2012-01-01/2012-01-31/?format=json
    var delegate: NBPManagerDetailDelegate?
    
    func fetchCurrency(tableName:String,code: String, dateFromString: String, dateToString: String){
        let ulrString = "\(NBPURLDetail)/\(tableName.lowercased())/\(code.lowercased())/\(dateFromString)/\(dateToString)/?format=json"
        
        performRequest(urlString: ulrString)
        
    }
    
    func performRequest(urlString: String){
        //Utworzenie URL
        if let url = URL(string: urlString) {
            //Utworzenie URLSession
            let session = URLSession(configuration: .default)
            
            //Przypisanie session do task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeDate = data {
//                    let dataString = String(data: safeDate, encoding: .utf8)
//                    print(dataString)
                    
                    if let nbp = self.parseJSON(nbpDataDetail: safeDate){
                        self.delegate?.didUpdateNBPDetail(nbp: nbp)
                    }
                }
            }
            
            //Start task
            task.resume()
            
        }
    }
    
    func parseJSON(nbpDataDetail: Data) -> NBPModelDetail?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(NBPDataDetail.self, from: nbpDataDetail)
            

            let table = decodedData.table
            let currency = decodedData.currency
            let code = decodedData.code
            let rates = decodedData.rates

            let nbpDetail = NBPModelDetail(table: table, currency: currency, code: code, rates: rates)
            return nbpDetail
        }catch{
            print(error)
            return nil
        }
    }
    
}
