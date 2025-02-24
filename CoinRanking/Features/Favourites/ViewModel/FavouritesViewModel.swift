//
//  FavouritesViewModel.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import Foundation
import UIKit
import SwiftUI
import Realm
import RealmSwift

class FavouritesViewModel: ObservableObject {
    @Published var favouritesData : [CoinObject] = []
    
    var presenter: UIViewController
    
    init(presenter: UIViewController
    ) {
        self.presenter = presenter
     
    }
    
    func getData() {
        let realm = try! Realm()
        favouritesData = Array(realm.objects(CoinObject.self))
    }
    
    func deleteFromRealm(at index: Int){
        guard index < favouritesData.count else { return }
        let realm = try! Realm()
        let coinToDelete = favouritesData[index]
        
        do {
            try realm.write {
                realm.delete(coinToDelete)
            }
            favouritesData.remove(at: index) // Update UI
        } catch {
            print("❌ Error deleting from Realm: \(error.localizedDescription)")
        }
    }
    
    func viewDetails(coinObject: CoinObject) {
        let coin = Coin(from: coinObject)
        let viewModel =  CoinDetailsViewModel(presenter: self.presenter,coin: coin)
        let swiftUIView = CoinDetails(viewModel: viewModel)
        let controller = UIHostingController(rootView: swiftUIView)
        self.presenter.pushViewController(viewController: controller)
    }
}
