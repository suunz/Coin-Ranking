//
//  CoinsListViewModel.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import Foundation
import Combine

class CoinsListViewModel: ObservableObject {
    @Published var coins: [Coin] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var currentPage = 1
    private let pageSize = 20
    private var totalItems = 0
    private var cancellables = Set<AnyCancellable>()

    func fetchCoinsList() {
        guard !isLoading else { return } // Prevent duplicate calls

        let urlString = "\(APIConfig.baseURL + APIConfig.Endpoints.coinsUrl)?limit=\(pageSize)&offset=\((currentPage - 1) * pageSize)"
        isLoading = true

        NetworkHelper.shared.fetch(urlString: urlString, responseType: CryptoResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let response):
                    self.totalItems = response.data.stats.total
                    self.coins.append(contentsOf: response.data.coins)
                    self.currentPage += 1 // Move to next page
                
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func canLoadMore() -> Bool {
        return coins.count < totalItems
    }
}
