//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .lightBlue],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Clayton, NC")
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundStyle(.white)
                    .padding()
                VStack(spacing: 10) {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                    Text("75°")
                        .font(.system(size: 70, weight: .medium))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 40)
                HStack(spacing: 20) {
                    WeatherDayView(dayOfWeek: "Thu", imageName: "cloud.fill", temperature: 81)
                    WeatherDayView(dayOfWeek: "Fri", imageName: "cloud.rain.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "Sat", imageName: "cloud.rain.fill", temperature: 70)
                    WeatherDayView(dayOfWeek: "Sun", imageName: "sun.max.fill", temperature: 78)
                    WeatherDayView(dayOfWeek: "Mon", imageName: "cloud.sun.fill", temperature: 78)
                }
                Spacer()
                Button {
                    print("tapped")
                } label: {
                    Text("Change Day Time")
                        .frame(width: 280, height: 50)
                        .background(.white)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
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
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}
