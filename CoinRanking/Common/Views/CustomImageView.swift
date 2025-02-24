//
//  CustomImageView.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct AsyncImageView: View {
    let url: String?

    var body: some View {

        WebImage(url: URL(string: url ?? ""))
            .resizable()
            .scaledToFit()
    }
}

