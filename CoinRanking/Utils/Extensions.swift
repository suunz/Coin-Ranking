//
//  Extensions.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//
import UIKit
import SDWebImage
import SDWebImageSVGCoder
import SwiftUI

extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            return
        }

        // Automatically detect & load PNG/SVG images
        self.sd_setImage(with: url, placeholderImage: placeholder, options: [.progressiveLoad]) { image, error, _, _ in
            if let error = error {
                print("❌ Failed to load image: \(error.localizedDescription)")
            } else {
                print("✅ Image loaded successfully")
            }
        }
    }
}

func screenWidth() -> CGFloat {
    return UIScreen.main.bounds.width
}

func screenHeight() -> CGFloat {
    return UIScreen.main.bounds.height
}


extension UIViewController {
    
    func pushViewController(viewController: UIViewController) {
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension View {
    func list_Row_Insets() -> some View {
        self.modifier(List_Row_Insets_Modifier())
    }
    
    func list_Row_Seperator() -> some View {
        self.modifier(List_Row_Sperator_Modifier())
    }
}

struct List_Row_Insets_Modifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content.listRowInsets(EdgeInsets())
        } else {
            content
        }
        
    }
}

struct List_Row_Sperator_Modifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets(top: -1, leading: -1, bottom: -1, trailing: -1))
                
        } else {
            content
        }
        
    }
}
