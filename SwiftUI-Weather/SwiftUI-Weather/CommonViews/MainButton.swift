//
//  MainButton.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct MainButton: View {
    
    var buttonText: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(buttonText)
            .frame(width: 280, height: 50)
            .background(backgroundColor.gradient)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}

#Preview {
    MainButton(buttonText: "Change Day Time", textColor: .white, backgroundColor: .blue)
}
