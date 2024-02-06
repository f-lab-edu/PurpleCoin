//
//  File.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

enum ScreenFigure {
    
    enum Ratio {
        static let HRatioValue = UIScreen.main.bounds.width / 390
        static let VRatioValue = UIScreen.main.bounds.height / 844
    }
    
    static let bounds = UIScreen.main.bounds
    static let margin: CGFloat = 17
    
    static func notchHeight() -> CGFloat {
        return UIDevice.current.isNotch ? 0.0 : 24.0
    }
    
    // TopView 노치가 있을때 없을때 Height
    static func topViewHeight() -> CGFloat {
        return UIDevice.current.isNotch ? 110 * Ratio.HRatioValue : 70
    }
    
    // BottomView 노치가(홈버튼) 있을때 없을때 Height
    static func bottomNavigationViewHeight() -> CGFloat {
        return UIDevice.current.isNotch ? 80 * Ratio.HRatioValue : 70 * Ratio.HRatioValue
    }
}

enum PurpleCoinFont {
    enum fontType: String {
        case extraBold = "ExtraBold"
        case bold = "BOLD"
        case semibold = "SEMIBOLD"
        case medium = "MEDIUM"
        case light = "LIGHT"
        case regular = "REGULAR"
    }
    static func font(type: fontType, size: CGFloat) -> UIFont {
        let fontSize = size * ScreenFigure.Ratio.HRatioValue
        let fontName = FontConfig.baseFont + type.rawValue
        guard let font = UIFont(name: fontName, size: fontSize) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}

enum PurpleCoinColor {
    static let pointColor = UIColor(red: 0.196, green: 0.055, blue: 0.337, alpha: 1)
    static let lightPointColor = UIColor(red: 0.358, green: 0.217, blue: 0.5, alpha: 1)
    static let darkPointColor =  UIColor(red: 0.278, green: 0.169, blue: 0.271, alpha: 1)
    static let gray =  UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
    static let red = UIColor(red: 0.984, green: 0.314, blue: 0.169, alpha: 1)
    static let blue = UIColor(red: 0.313, green: 0.423, blue: 1, alpha: 1)
    static let selectColor = UIColor(red: 0.897, green: 0.573, blue: 1, alpha: 1)
}

enum CoinChange {
    case rise
    case even
    case fall
}
