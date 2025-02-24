//
//  CoinsListViewController.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//
//
import UIKit
import Foundation
import Combine
import SwiftUI

class CoinsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = CoinsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpNavigationBar()
        bindViewModel()
        viewModel.fetchCoinsList()
    }
    
    private func setUpNavigationBar() {
        self.title = "Coins List"

        // Right Bar Button - Favorites
        let favoritesButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(openFavorites)
        )
        
        self.navigationItem.rightBarButtonItem = favoritesButton

        // Customize appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = AppColors.uiColor(AppColors.primary) // Button color
    }
    
    // Method to handle Favorites button tap
    @objc private func openFavorites() {
        
        let viewModel =  FavouritesViewModel(presenter: self)
        let swiftUIView = FavouriteCoins(viewModel: viewModel)
        let controller = UIHostingController(rootView: swiftUIView)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

    private func setUp() {
        self.navigationItem.hidesBackButton = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "CoinCell")

    }

    private func bindViewModel() {
        viewModel.$coins.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellables)
        
        viewModel.$errorMessage.sink { error in
            if let error = error {
                print("❌ API Call Failed: \(error)")
            }
        }.store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
}

// MARK: - TableView DataSource & Delegate
extension CoinsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.coins.count)
        return viewModel.coins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as? CoinCell else {
                return UITableViewCell()
            }
            
            let coin = viewModel.coins[indexPath.row]
            cell.coin = coin
            
            // **Trigger Pagination when reaching last cell**
            if indexPath.row == viewModel.coins.count - 1 && viewModel.canLoadMore() {
                viewModel.fetchCoinsList()
            }

            return cell
        }
    
    // MARK: - Handle Cell Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCoin = viewModel.coins[indexPath.row]
        let viewModel =  CoinDetailsViewModel(presenter: self,coin: selectedCoin)
        let swiftUIView = CoinDetails(viewModel: viewModel)
        let controller = UIHostingController(rootView: swiftUIView)
        self.navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true) // Optional: Deselect cell after tap
    }
    
    // MARK: - Swipe Left to Save to Realm
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let saveAction = UIContextualAction(style: .normal, title: "Favourite") { _, _, completionHandler in
                let coin = self.viewModel.coins[indexPath.row]
                let coinDict = self.convertCoinToDictionary(coin)
                RealmHelper().saveCoinToRealm(from: coinDict)
                completionHandler(true)
            }
            
            saveAction.backgroundColor = .systemGreen // Customize swipe action color
            return UISwipeActionsConfiguration(actions: [saveAction])
        }

        // MARK: - Convert Coin Model to Dictionary
        private func convertCoinToDictionary(_ coin: Coin) -> [String: Any] {
            return [
                "uuid": coin.uuid,
                "symbol": coin.symbol,
                "name": coin.name,
                "color": coin.color ?? "",
                "iconUrl": coin.iconUrl,
                "marketCap": coin.marketCap,
                "price": coin.price,
                "listedAt": coin.listedAt,
                "tier": coin.tier,
                "change": coin.change,
                "rank": coin.rank,
                "sparkline": coin.sparkline,
                "lowVolume": coin.lowVolume,
                "coinrankingUrl": coin.coinrankingUrl,
                "24hVolume": coin.volume24h,
                "btcPrice": coin.btcPrice
            ]
        }
}
