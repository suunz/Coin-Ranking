//
//  CommonFunctions.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/24/25.
//

import Foundation

class CommonFunctions {
    
    func getPrice(price: String)-> String {
        var amount: String = ""
        if let doubleValue = Double(price) {
            amount = String(format: "%.2f", doubleValue)
        }
        return amount
    }
}

