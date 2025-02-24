//
//  CoinDetails.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import SwiftUI
import Charts

struct CoinDetails: View {
    @ObservedObject var viewModel: CoinDetailsViewModel
    
    @ViewBuilder
    func cryptoCard(cryptoData: Coin) -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    AsyncImageView(url: cryptoData.iconUrl) // Use dynamic image URL
                        .frame(width: 60, height: 60)
                    VStack(alignment: .leading) {
                        
                        Text(cryptoData.name)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text(cryptoData.symbol)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .frame(width: 50, height: 30)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    VStack (alignment: .leading){
                        infoRow(title: "24 Hour Volume", subTitle: cryptoData.volume24h)
                        infoRow(title: "Market Cap", subTitle: viewModel.coin.marketCap)

                    }
                    Spacer()
                    VStack (alignment: .leading){
                        infoRow(title: "Price", subTitle: viewModel.getPrice(price: cryptoData.price))
                        infoRow(title: "Listed At", subTitle: "\(viewModel.coin.listedAt)")

                    }
                    Spacer()
                    VStack (alignment: .leading){
                        infoRow(title: "Rank", subTitle: "\(cryptoData.rank)")
                        infoRow(title: "Tier", subTitle:"\( viewModel.coin.tier)")

                    }
                }
                
            }
            .padding()
        }
        .padding(.horizontal)
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center, spacing: 12){
                    cryptoCard(cryptoData: viewModel.coin)
                    Chart {
                        ForEach(Array(viewModel.coin.validSparkline.enumerated()), id: \.0) { index, value in
                            LineMark(
                                x: .value("Time", index),
                                y: .value("Price", value)
                            )
                            .foregroundStyle(Color.green)
                        }
                    }
                    .frame(width: screenWidth() - 32, height: 150)
                    .padding(.vertical, 16)
                    
                    
                }
            }
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {
                }) {
                    Text("Buy")
                        .font(.caption)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                }) {
                    Text("Sell")
                        .font(.caption)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.swiftUIColor(AppColors.primary))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
        }
    }
    
    @ViewBuilder
    func coinNameSymbolView(title: String, subTitle: String) -> some View {
          
        HStack (spacing: 0){
            Text(title)
            Text(subTitle)
        }
    }
    
    @ViewBuilder
    func infoRow(title: String, subTitle: String) -> some View {
          
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(subTitle)
                .font(.caption)
                .bold()
        }
    }
}

#Preview {
    CoinDetails(viewModel: CoinDetailsViewModel(presenter: UIViewController(), coin: Coin(uuid: "", symbol: "", name: "", color: "", iconUrl: "", marketCap: "", price: "", listedAt: 0, tier: 0, change: "", rank: 0, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "", btcPrice: "", contractAddresses: [])))
}
