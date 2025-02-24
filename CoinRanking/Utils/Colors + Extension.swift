//
//  Colors + Extension.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/22/25.
//

import Foundation
import SwiftUI
import UIKit

class AppColors {
    static let primary = "#96342F"
    static let secondary = "#f1c40f"
    static let background = "#ecf0f1"
    static let textPrimary = "#2c3e50" 
    
    // UIColor for UIKit
    static func uiColor(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hex: hex, alpha: alpha)
    }
    
    // SwiftUI Color
    static func swiftUIColor(_ hex: String, alpha: Double = 1.0) -> Color {
        return Color(UIColor(hex: hex, alpha: CGFloat(alpha)))
    }
}
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        self.init(UIColor(hex: hex, alpha: CGFloat(alpha)))
    }
}
