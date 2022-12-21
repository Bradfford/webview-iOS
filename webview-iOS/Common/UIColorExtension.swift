//
//  UIColorExtension.swift
//  webview-iOS
//
//  Created by Millfford Robert Lima Bradshaw on 15/12/22.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        
    }

    static let kGiroBackgroundGrayColor : UIColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    static let kGiroLightGrayColor : UIColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
    static let kGiroGrayColor : UIColor = UIColor(red: 74/255, green: 75/255, blue: 74/255, alpha: 1.0)
    static let kGiroGrayDisabledBtnColor : UIColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
    static let kGiroBlackColor : UIColor = UIColor(red: 26/255, green: 27/255, blue: 26/255, alpha: 1.0)
    static let kGiroGreenColor : UIColor = UIColor(red: 117/255, green: 174/255, blue: 80/255, alpha: 1.0)
    static let kGiroGreenSecondaryColor : UIColor = UIColor(red: 24/255, green: 123/255, blue: 122/255, alpha: 1.0)
    static let kGiroRedColor : UIColor = UIColor(red: 220/255, green: 33/255, blue: 58/255, alpha: 1.0)
}
