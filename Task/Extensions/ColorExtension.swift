//
//  ColorExtension.swift
//  Task
//
//  Created by Andrey on 22.06.2023.
//

import SwiftUI

extension Color {
    static let background = Color(red: Double(0x03) / 255.0, green: Double(0x03) / 255.0, blue: Double(0x03) / 255.0)
    static let greenColor = Color(red: Double(0x3A) / 255.0, green: Double(0xE8) / 255.0, blue: Double(0xAD) / 255.0)
    static let blueColor = Color(red: Double(0x07) / 255.0,   green: Double(0x79) / 255.0,  blue: Double(0xFF) / 255.0)
        
       
        
     
}

extension View {
    // Fonts
    func boldFont_32(size: CGFloat = 32) -> some View {
        return self.font(.system(size: size, weight: .bold))
    }
    
    func boldFont_24(size: CGFloat = 24) -> some View {
        return self.font(.system(size: size, weight: .bold))
    }
    
    func boldFont_18(size: CGFloat = 18) -> some View {
        return self.font(.system(size: size, weight: .bold))
    }
    
    func boldFont_16(size: CGFloat = 16) -> some View {
        return self.font(.system(size: size, weight: .bold))
    }
    
    func mediumFont_18(size: CGFloat = 18) -> some View {
        return self.font(.system(size: size, weight: .medium))
    }
    
    func mediumFont_14(size: CGFloat = 14) -> some View {
        return self.font(.system(size: size, weight: .medium))
    }
    func mediumFont_12(size: CGFloat = 12) -> some View {
        return self.font(.system(size: size, weight: .medium))
    }
    
    // FontColor
    func whiteForegroundWithOpacity(_ opacity: Double = 0.8) -> some View {
        return self
            .foregroundColor(.white)
            .opacity(opacity)
    }
}


