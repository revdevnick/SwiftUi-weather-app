//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight: Bool = false
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                CityView(cityName: "Clayton, NC")
                MainWeatherStatusView(animate: $animate,
                                      imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                                      temperature: 75)
                HStack(spacing: 20) {
                    WeatherDayView(animate: $animate,
                                   dayOfWeek: "Thu",
                                   imageName: isNight ? "cloud.moon.fill" : "cloud.fill",
                                   temperature: 81)
                    WeatherDayView(animate: $animate,
                                   dayOfWeek: "Fri",
                                   imageName: "cloud.rain.fill",
                                   temperature: 74)
                    WeatherDayView(animate: $animate,
                                   dayOfWeek: "Sat",
                                   imageName: "cloud.rain.fill",
                                   temperature: 70)
                    WeatherDayView(animate: $animate,
                                   dayOfWeek: "Sun",
                                   imageName: isNight ? "moon.stars.fill" : "sun.max.fill",
                                   temperature: 78)
                    WeatherDayView(animate: $animate,
                                   dayOfWeek: "Mon",
                                   imageName: isNight ? "cloud.moon.fill" : "cloud.sun.fill",
                                   temperature: 78)
                }
                Spacer()
                Button {
                    isNight.toggle()
                    animate.toggle()
                } label: {
                    MainButton(buttonText: "Change Day Time", textColor: .white, backgroundColor: .orange)
                }
                Spacer()
            }
        }
        .onAppear {
            animate.toggle()
        }
    }
}

#Preview {
    ContentView()
}






