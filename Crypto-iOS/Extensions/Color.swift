//
//  Color.swift
//  Crypto-iOS
//
//  Created by Prashanna Rajbhandari on 27/04/2023.
//

import Foundation
import SwiftUI

extension Color{
    static let theme =  ColorTheme() 
}

struct ColorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    let launchBackground = Color("LaunchBackgroundColor")
    let launchAccent = Color("LaunchAccentColor")
    
}



