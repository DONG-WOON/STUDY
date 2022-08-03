///
//  Color.swift
//  STUDYA
//
//  Created by 신동훈 on 2022/07/31.
//

import UIKit

enum AssetColor {
    case purple, black, placeholder, defaultGray, lightPurple, kakao, naver, kakaoBrown
}

extension UIColor {
    
    static func appColor(_ name: AssetColor) -> UIColor {
        switch name {
        case .purple:
            return UIColor(red: 108/255, green: 70/255, blue: 232/255, alpha: 1)
        case .lightPurple:
            return UIColor(red: 214/255, green: 209/255, blue: 232/255, alpha: 1)
        case .black:
            return UIColor(red: 0.208, green: 0.178, blue: 0.283, alpha: 1)
        case .placeholder:
            return UIColor(red: 0.827, green: 0.824, blue: 0.863, alpha: 1)
        case .defaultGray:
            return UIColor(red: 0.839, green: 0.82, blue: 0.91, alpha: 1)
        case .kakao:
            return UIColor(red: 254/255, green: 229/255, blue: 0, alpha: 1)
        case .kakaoBrown:
            return UIColor(red: 60/255, green: 30/255, blue: 30/255, alpha: 1)
        case .naver:
            return UIColor(red: 3/255, green: 199/255, blue: 90/255, alpha: 1)
        }
    }
}