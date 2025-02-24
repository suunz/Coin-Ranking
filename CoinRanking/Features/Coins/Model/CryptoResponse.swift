//
//  CryptoResponse.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//


import Foundation

// MARK: - Root Response
struct CryptoResponse: Codable {
    let status: String
    let data: CryptoData
}

// MARK: - Data
struct CryptoData: Codable {
    let stats: CryptoStats
    let coins: [Coin]
}

// MARK: - Stats
struct CryptoStats: Codable {
    let total: Int
    let totalCoins: Int
    let totalMarkets: Int
    let totalExchanges: Int
    let totalMarketCap: String
    let total24hVolume: String
}

// MARK: - Coin
struct Coin: Codable {
    let uuid: String
    let symbol: String
    let name: String
    let color: String?
    let iconUrl: String
    let marketCap: String
    let price: String
    let listedAt: Int
    let tier: Int
    let change: String
    let rank: Int
    let sparkline: [String?]
    let lowVolume: Bool
    let coinrankingUrl: String
    let volume24h: String
    let btcPrice: String
    let contractAddresses: [String]
    var validSparkline: [Double] {
            return sparkline.compactMap { Double($0 ?? "0") }
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color, iconUrl, marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume, coinrankingUrl
        case volume24h = "24hVolume"
        case btcPrice, contractAddresses
    }
}


extension Coin {
    init(from coinObject: CoinObject) {
        self.uuid = coinObject.uuid
        self.symbol = coinObject.symbol
        self.name = coinObject.name
        self.color = coinObject.color
        self.iconUrl = coinObject.iconUrl ?? ""
        self.marketCap = coinObject.marketCap
        self.price = coinObject.price
        self.listedAt = coinObject.listedAt
        self.tier = coinObject.tier
        self.change = coinObject.change
        self.rank = coinObject.rank
        self.sparkline = Array(coinObject.sparkline) // Convert Realm `List<String?>` to `[String?]`
        self.lowVolume = coinObject.lowVolume
        self.coinrankingUrl = coinObject.coinrankingUrl ?? ""
        self.volume24h = coinObject.volume24h
        self.btcPrice = coinObject.btcPrice
        self.contractAddresses = [] // Set empty array if not stored in Realm
    }
}
