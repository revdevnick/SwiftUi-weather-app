//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @Bindable var model = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                self.backgroundView()
                VStack(alignment: .leading) {
                    CurrentCityForecastView(
                        name: model.cityName,
                        date: model.todayDate,
                        current: model.currentCondition,
                        temp: model.currentTemp,
                        summary: model.summary,
                        wind: model.currentWind,
                        humidity: model.currentHumidity,
                        visbility: model.currentVisbility)
                    FutureForecastView(days: model.forecast?.forecast.forecastDay ?? [])
                    
                    Spacer()
                }
            }
        }
        .task {
            await model.fetchWeather(for: "27527")
        }
        .onAppear {
            model.animate.toggle()
        }
    }
    
    private func backgroundView() -> some View {
        ContainerRelativeShape()
            .fill(Color.sunnyYellow.gradient)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
