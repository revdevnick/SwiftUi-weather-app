//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @Bindable var model = ViewModel()
    @State var locationManager = LocationManager()
    
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
            try? await locationManager.requestUserAuthorization()
            try? await locationManager.startCurrentLocationUpdates()
            let location = "\(locationManager.location?.coordinate.latitude.formatted() ?? "35.650823098002476"),\(locationManager.location?.coordinate.longitude.formatted() ?? "-78.4571531147212")"
            await model.fetchWeather(for: location)
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
