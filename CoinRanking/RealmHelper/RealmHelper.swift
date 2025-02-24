//
//  RealmHelper.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    func saveCoinToRealm(from json: [String: Any]) {
        let realm = try! Realm()
        
        guard let uuid = json["uuid"] as? String,
              let symbol = json["symbol"] as? String,
              let name = json["name"] as? String,
              let marketCap = json["marketCap"] as? String,
              let price = json["price"] as? String,
              let listedAt = json["listedAt"] as? Int,
              let tier = json["tier"] as? Int,
              let change = json["change"] as? String,
              let rank = json["rank"] as? Int,
              let lowVolume = json["lowVolume"] as? Bool,
              let btcPrice = json["btcPrice"] as? String,
              let volume24h = json["24hVolume"] as? String else { return }
        
        let color = json["color"] as? String
        let iconUrl = json["iconUrl"] as? String
        let coinrankingUrl = json["coinrankingUrl"] as? String
        let sparkline = json["sparkline"] as? [String?] ?? []
        
        let coinObject = CoinObject(uuid: uuid, symbol: symbol, name: name, color: color, iconUrl: iconUrl, marketCap: marketCap, price: price, listedAt: listedAt, tier: tier, change: change, rank: rank, sparkline: sparkline, lowVolume: lowVolume, coinrankingUrl: coinrankingUrl, volume24h: volume24h, btcPrice: btcPrice)
        
        try! realm.write {
            realm.add(coinObject, update: .modified) // Prevent duplicates
        }
    }
    
}
