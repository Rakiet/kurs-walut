//
//  NBPModel.swift
//  kursy
//
//  Created by Piotr Żakieta on 26/03/2022.
//

import Foundation


struct NBPModel{
    let table: String
    let no: String
    let effectiveDate: String
    let rates: [Rates]
}

struct RatesModel{
    let currency: String
    let code: String
    let mid: Double
}

struct NBPModelDetail: Codable{
    let table: String
    let currency: String
    let code: String
    let rates: [RatesDetail]
    
}


