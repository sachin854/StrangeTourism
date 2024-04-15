//
//  CustomColor.swift
//  pmToolMobile
//
//  Created by Sachin on 18/08/23.
//

import SwiftUI


class CustomColor {
    static func hexColor(_ hex: UInt32, alpha: Double = 1.0) -> Color {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }

    static let customColor = hexColor(0xff7A59E5)
    static let labelColor = hexColor(0xFAB248)
}

