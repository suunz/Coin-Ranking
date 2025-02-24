//
//  CoinDetailsViewModel.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import Foundation
import SwiftUI
import Realm
import RealmSwift

class CoinDetailsViewModel: ObservableObject {
    
    var presenter: UIViewController
    var coin: Coin
    
    init(presenter: UIViewController, coin: Coin
    ) {
        self.presenter = presenter
        self.coin = coin
    }
    
    func getPrice(price: String)-> String {
        var amount: String = ""
        if let doubleValue = Double(price) {
            amount = String(format: "%.2f", doubleValue)
        }
        return amount
    }
}
