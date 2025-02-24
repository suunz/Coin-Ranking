//
//  FavouriteCoins.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import SwiftUI

struct FavouriteCoins: View {
    @ObservedObject var viewModel: FavouritesViewModel
    var body: some View {
        VStack {
            if viewModel.favouritesData.isEmpty {
                VStack {
                    Image(systemName: "star.slash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    
                    Text("No favourites yet")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                }
            } else {
                List {
                    ForEach(0..<viewModel.favouritesData.count, id: \.self) { index in
                        cryptoCard(cryptoData: viewModel.favouritesData[index])
                            .padding()
                            .listRowInsets(EdgeInsets())
                            .swipeActions(edge: .trailing) {
                                deleteAction(for: index)
                            }
                            .onTapGesture {
                                viewModel.viewDetails(coinObject: viewModel.favouritesData[index])
                            }
                    }
                }
                .listRowSeparator(.hidden)
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            viewModel.getData()
        }
    }

    
    
//    var body: some View {
//        
//            List {
//                ForEach(0..<(viewModel.favouritesData.count), id: \.self) { index in
//                    cryptoCard(cryptoData: viewModel.favouritesData[index])
//                        .padding()
//                        .listRowInsets(EdgeInsets())
//                        .swipeActions(edge: .trailing) {
//                            deleteAction(for: index)
//                        }
//                        .onTapGesture {
//                            viewModel.viewDetails(coinObject: viewModel.favouritesData[index])
//                        }
//                }
//            }
//            .listRowSeparator(.hidden)
//            .listStyle(PlainListStyle())
//        .onAppear{
//            viewModel.getData()
//        }
//    }
    
    private func deleteAction(for index: Int) -> some View {
        Button(role: .destructive) {
            // Handle delete action
            viewModel.deleteFromRealm(at: index)
        } label: {
            VStack {
                Image(systemName: "wrongwaysign.fill")
                Text("Unfavourite")
            }
        }
        .tint(.red)
    }
    
    @ViewBuilder
    func cryptoCard(cryptoData: CoinObject) -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                HStack {
                    AsyncImageView(url: cryptoData.iconUrl) // Use dynamic image URL
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
                
                HStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("24 Hour Volume")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(cryptoData.volume24h)
                            .font(.caption)
                            .bold()
                    }
                    VStack(alignment: .leading) {
                        Text("Market Cap")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(cryptoData.marketCap)
                            .font(.caption)
                            .bold()
                    }
                }
            }
            .padding()
        }
        .frame(height: 100)
        .padding(.horizontal)
    }
}



