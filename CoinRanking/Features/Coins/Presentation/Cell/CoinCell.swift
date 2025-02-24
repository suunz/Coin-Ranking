//
//  CoinCell.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import UIKit

class CoinCell: UITableViewCell {

    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    var coin: Coin? {
        didSet {
            configure()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        coinImage.clipsToBounds = true
    }
    
    func configure() {
        coinName.text = coin?.name ?? ""
        coinName.font = UIFont.boldSystemFont(ofSize: coinName.font.pointSize)
        var price: String = ""
        price = CommonFunctions().getPrice(price: coin?.price ?? "")
        priceLabel.text = price
        
        // Load Image Asynchronously
        
        if let iconUrl = coin?.iconUrl {
            self.coinImage.loadImage(from: iconUrl, placeholder: UIImage(named: "swiftlogo"))
        } else {
            self.coinImage.image = UIImage(named: "swiftlogo")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
