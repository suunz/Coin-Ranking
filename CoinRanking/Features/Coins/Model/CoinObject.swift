//
//  CoinObject.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import Foundation
import RealmSwift

class CoinObject: Object {
    @Persisted(primaryKey: true) var uuid: String
    @Persisted var symbol: String
    @Persisted var name: String
    @Persisted var color: String?
    @Persisted var iconUrl: String?
    @Persisted var marketCap: String
    @Persisted var price: String
    @Persisted var listedAt: Int
    @Persisted var tier: Int
    @Persisted var change: String
    @Persisted var rank: Int
    @Persisted var sparkline: List<String?> // List type for arrays
    @Persisted var lowVolume: Bool
    @Persisted var coinrankingUrl: String?
    @Persisted var volume24h: String // Renamed for clarity
    @Persisted var btcPrice: String
    
    // Custom initializer for convenience
    convenience init(uuid: String, symbol: String, name: String, color: String?, iconUrl: String?, marketCap: String, price: String, listedAt: Int, tier: Int, change: String, rank: Int, sparkline: [String?], lowVolume: Bool, coinrankingUrl: String?, volume24h: String, btcPrice: String) {
        self.init()
        self.uuid = uuid
        self.symbol = symbol
        self.name = name
        self.color = color
        self.iconUrl = iconUrl
        self.marketCap = marketCap
        self.price = price
        self.listedAt = listedAt
        self.tier = tier
        self.change = change
        self.rank = rank
        self.sparkline.append(objectsIn: sparkline)
        self.lowVolume = lowVolume
        self.coinrankingUrl = coinrankingUrl
        self.volume24h = volume24h
        self.btcPrice = btcPrice
    }
}

