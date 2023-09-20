//
//  WeatherDayView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct WeatherDayView: View {
    
    @Binding var animate: Bool
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(.white)
                .textCase(.uppercase)
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .symbolEffect(.bounce, value: animate)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    WeatherDayView(animate: .constant(true), dayOfWeek: "Mon", imageName: "cloud.sun.fill", temperature: 78)
        .background(Color.blue)
}
