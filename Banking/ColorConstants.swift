//
//  ColorConstants.swift
//  Banking
//
//  Created by Kevni Woodside on 4/11/22.
//

import SwiftUI

struct ColorConstants {
    //static let primary                  = Color.init(red: 47/255, green: 16/255, blue: 118/255)
    static let primary                  = Color.init(.white)
    //static let secondary                = Color.init(red: 142/255, green: 119/255, blue: 204/255)
    static let secondary                = Color.init(red: 0/255, green: 45/255, blue: 114/255)
    static let imageTint                = Color.init(red: 182/255, green: 152/255, blue: 255/255)
    static let imageTint2               = Color.init(red: 120/255, green: 90/255, blue: 201/255)
    static let border                   = Color.init(red: 66/255, green: 38/255, blue: 135/255)
    static let lightBlue                = Color.init(red: 189/255, green: 238/255, blue: 252/255)
    
    static let cardTopRight             = Color.init(red: 255/255, green: 72/255, blue: 72/255)
    static let cardBottomLeft           = Color.init(red: 0/255, green: 45/255, blue: 114/255)
    
    //static let graphLine                = Color.init(red: 249/255, green: 24/255, blue: 253/255)
    static let graphLine                = Color.init(red: 255/255, green: 72/255, blue: 72/255)
    static let graphNumber              = Color.init(red: 77/255, green: 49/255, blue: 162/255)
    static let graphBar                 = Color.init(red: 0/255, green: 45/255, blue: 114/255)
    static let graphBarHighlighted      = Color.init(red: 5/255, green: 92/255, blue: 168/255)
    
    static let cardBackground           = LinearGradient(
        gradient: Gradient(colors: [cardTopRight.opacity(0.9), cardBottomLeft]),
                                            startPoint: .topTrailing,
                                            endPoint: .bottomLeading)
    
    static let barBackground            = LinearGradient(
                                            gradient: Gradient(colors: [graphBar.opacity(0.2), graphBar.opacity(0.8)]),
                                            startPoint: .top,
                                            endPoint: .bottom)
    
    static let barHighlightedBackground = LinearGradient(
                                            gradient: Gradient(colors: [graphBarHighlighted.opacity(0.2), graphBarHighlighted.opacity(0.8)]),
                                            startPoint: .top,
                                            endPoint: .bottom)
}

