//
//  MainWeatherStatusView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct MainWeatherStatusView: View {
    
    @Binding var animate: Bool
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .symbolEffect(.bounce.up, options: .speed(1.1).repeat(2), value: animate)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(.white)
        }
        .padding(.bottom, 40)
    }
}

#Preview {
    MainWeatherStatusView(animate: .constant(true), imageName: "sun.max.fill", temperature: 76)
        .background(Color.blue)
}
