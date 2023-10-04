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
                BackgroundView(isNight: model.isNight)
                VStack {
                    CityView(cityName: "\(model.forecast?.location.cityName ?? "N/A"), \(model.forecast?.location.region ?? " ??")")
                    MainWeatherStatusView(animate: $model.animate,
                                          imageName: model.forecast?.current?.condition.sfSymbol ?? "sun.max.trianglebadge.exclamationmark.fill",
                                          temperature: model.forecast?.current?.tempF ?? 0)
                    Text("3-Day Forecast")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.bottom, 20)
                    HStack(spacing: 20) {
                        ForEach(model.forecast?.forecast.forecastDay ?? [], id: \.self) { day in
                            WeatherDayView(dayOfWeek: day.dayOfWeekFormatted ,
                                           imageName: day.day.condition.sfSymbol,
                                           temperature: day.day.maxTempF)
                        }
                    }
                    .symbolEffect(.bounce, value: model.animate)
                    Spacer()
                    Button {
                        model.isNight.toggle()
                        model.animate.toggle()
                    } label: {
                        MainButton(buttonText: "Change Day Time", textColor: .white, backgroundColor: .orange)
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AsyncButton {
                        model.isUpdating.toggle()
                        do {
                            model.forecast = try await model.getForecast()
                        } catch WeatherAPIError.invalidUrl {
                            print("invalid Url")
                        } catch WeatherAPIError.invalidResponse {
                            print("invalid Response")
                        } catch WeatherAPIError.invalidData {
                            print("invalid Data")
                        } catch {
                            print("unexpected error")
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .rotationEffect(.degrees(model.isUpdating ? 360 : 0), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .animation(.linear.repeatForever(autoreverses: false), value: model.isUpdating)
                            .tint(model.isUpdating ? .lightBlue : .white)
                    }
                }
            }
        }
        .task {
            do {
                model.forecast = try await model.getForecast()
            } catch WeatherAPIError.invalidUrl {
                print("invalid Url")
            } catch WeatherAPIError.invalidResponse {
                print("invalid Response")
            } catch WeatherAPIError.invalidData {
                print("invalid Data")
            } catch {
                print("unexpected error")
            }
        }
        .onAppear {
            model.animate.toggle()
        }
    }
}

#Preview {
    ContentView()
}
