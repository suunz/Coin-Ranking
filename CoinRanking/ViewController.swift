//
//  ViewController.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.routeToHome()
        }
        
    }

    private func routeToHome() {
        let storyboard = UIStoryboard(name: "CoinsList", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "CoinsListViewController") as? CoinsListViewController {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}

