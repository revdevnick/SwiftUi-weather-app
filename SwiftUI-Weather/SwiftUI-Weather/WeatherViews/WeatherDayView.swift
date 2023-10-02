//
//  WeatherDayView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Text(dayOfWeek)
                .font(.system(size: 22, weight: .medium, design: .default))
                .foregroundStyle(.white)
                .textCase(.uppercase)
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 52, height: 52)
            Text("\(temperature)°")
                .font(.system(size: 32, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    WeatherDayView(dayOfWeek: "Mon", imageName: "cloud.sun.fill", temperature: 78)
        .background(Color.blue)
}
