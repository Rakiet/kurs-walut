//
//  NBPData.swift
//  kursy
//
//  Created by Piotr Żakieta on 26/03/2022.
//

import Foundation

struct NBPData: Decodable{
    
    let table: String
    let no: String
    let effectiveDate: String
    let rates: [Rates]
}

struct Rates: Decodable{
    let currency: String
    let code: String
    let mid: Double
}


