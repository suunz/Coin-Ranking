

Overview

This application provides users with real-time cryptocurrency data, allowing them to browse the top 100 coins, view detailed information about each coin, and manage their favorite coins efficiently.

Features

Screen 1: Top Coins List

Displays a list of the top 100 cryptocurrencies with pagination (loading 20 coins at a time).

Each coin entry includes:

Icon

Name

Current Price

Symbol

Swipe left to favorite a coin.

Screen 2: Cryptocurrency Details

Displays in-depth details of a selected coin, including:

Name

Performance chart/graph

Current Price

Other relevant statistics

Screen 3: Favorites Screen

Shows a list of all favorited cryptocurrencies.

Allows users to view detailed information of their favorite coins.

Swipe left to unfavorite a coin from the list.


Installation Guide:
1. Clone the repository
 git clone https://github.com/suunz/Coin-Ranking.git
 
2. Navigate to the project directory: 
 cd your-project-directory
 
3. Open the .xcworkspace file in Xcode: 
 open CoinRanking.xcworkspace
 
4. Build and run the project in Xcode.

Technologies Used: 

1. UIKit/ SwiftUI
2. Charts (for performance graph)
3. SDWebImage
4. Realm
5. URLSession   

Architecture Used:
 This project uses the highly preferred MVVM architecture. MVVM architecture known widely for the separation of concerns is used instead of traditional MVC architecture.
