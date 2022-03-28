//
//  NBPData.swift
//  kursy
//
//  Created by Piotr Żakieta on 26/03/2022.
//

import Foundation

struct NBPData: Codable{
    
    let table: String
    let no: String
    let effectiveDate: String
    let rates: [Rates]
}

struct Rates: Codable{
    let currency: String
    let code: String
    let mid: Double
}
//struct dla kursow srednich danej waluty z zakresem dat
struct NBPDataDetail: Codable{
    let table: String
    let currency: String
    let code: String
    let rates: [RatesDetail]
    
}
//struct dla kursow srednich danej waluty z zakresem dat
struct RatesDetail: Codable{
    let no: String
    let effectiveDate: String
    let mid: Double
}


