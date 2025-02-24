//
//  CoinDetailsViewModelTests.swift
//  CoinRankingTests
//
//  Created by Sanjay Tandukar on 2/22/25.
//

import Foundation
import XCTest
@testable import CoinRanking

class CoinDetailsViewModelTests: XCTestCase {

    func testGetPrice_ValidNumber_ReturnsFormattedString() {
        // Given
        let viewModel = CoinDetailsViewModel(presenter: UIViewController(), coin: Coin.example)
        
        // When
        let formattedPrice = viewModel.getPrice(price: "1234.5678")
        
        // Then
        XCTAssertEqual(formattedPrice, "1234.57", "Price should be rounded to 2 decimal places")
    }
    
    func testGetPrice_InvalidNumber_ReturnsEmptyString() {
        // Given
        let viewModel = CoinDetailsViewModel(presenter: UIViewController(), coin: Coin.example)
        
        // When
        let formattedPrice = viewModel.getPrice(price: "invalid_number")
        
        // Then
        XCTAssertEqual(formattedPrice, "", "Invalid input should return an empty string")
    }
    
    func testGetPrice_IntegerInput_ReturnsTwoDecimalPlaces() {
        // Given
        let viewModel = CoinDetailsViewModel(presenter: UIViewController(), coin: Coin.example)
        
        // When
        let formattedPrice = viewModel.getPrice(price: "100")
        
        // Then
        XCTAssertEqual(formattedPrice, "100.00", "Integer should be formatted with two decimal places")
    }
}

// Extension to create a mock Coin object for testing
extension Coin {
    static var example: Coin {
        return Coin(uuid: "1", symbol: "BTC", name: "Bitcoin", color: "#f7931A", iconUrl: "", marketCap: "", price: "", listedAt: 0, tier: 1, change: "", rank: 1, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "", btcPrice: "", contractAddresses: [])
    }
}
