//
//  Extension+Font.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/7/23.
//

import SwiftUI

extension Font {
    
    enum SFCompactDisplayFont: String {
        case black = "SFCompactDisplay-Black"
        case bold = "SFCompactDisplay-Bold"
        case heavy = "SFCompactDisplay-Heavy"
        case light = "SFCompactDisplay-Light"
        case medium = "SFCompactDisplay-Medium"
        case regular = "SFCompactDisplay-Regular"
        case semibold = "SFCompactDisplay-Semibold"
        case thin = "SFCompactDisplay-Thin"
        case ultralight = "SFCompactDisplay-Ultralight"
    }
    
    static func sfCompactFont(_ type: SFCompactDisplayFont = .regular, size: CGFloat = 20) -> Font {
        return .custom(type.rawValue, size: size)
    }
}
