//
//  Extensions.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 10/29/21.
//

import UIKit

// MARK: - Custom Colors
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let cashYellow = UIColor.rgb(red: 255, green: 222, blue: 89)
    static let cashGreen = UIColor.rgb(red: 36, green: 141, blue: 56)
}
