//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @Bindable var model = ViewModel()
    
    
    let dateFormatter = DateFormatter()
    
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
                            model.forecast = try await getForecast()
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
                model.forecast = try await getForecast()
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

func getForecast() async throws -> Forecast {
    let endpoint = "https://weatherapi-com.p.rapidapi.com/forecast.json?q=27527&days=3"
    
    guard let url = URL(string: endpoint) else { throw WeatherAPIError.invalidUrl }
    
    guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"), let keys = NSDictionary(contentsOfFile: path), let apiKey = keys["WeatherAPIKey"] as? String else {
        throw WeatherAPIError.forbidden("Key not found")
    }
    let headers = [
        "X-RapidAPI-Key": apiKey,
        "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
    ]
    
    var request = URLRequest(url: url)
    request.cachePolicy = .useProtocolCachePolicy
    request.timeoutInterval = 10.0
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let response = response as? HTTPURLResponse else {
        throw  WeatherAPIError.invalidResponse
    }
    
    switch response.statusCode {
    case 200:
        do {
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(Forecast.self, from: data)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                throw WeatherAPIError.forbidden("Test")
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                throw WeatherAPIError.forbidden("Test")
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                throw WeatherAPIError.forbidden("Test")
            } catch {
                print("error: ", error)
                throw WeatherAPIError.forbidden("Test")
            }
        }
    default:
        throw WeatherAPIError.invalidResponse
    }
    throw WeatherAPIError.invalidResponse
}

#Preview {
    ContentView()
}


enum WeatherAPIError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case forbidden(String)
}



struct AsyncButton<Label: View>: View {
    var action: () async -> Void
    @ViewBuilder var label: () -> Label

    @State private var isPerformingTask = false

    var body: some View {
        Button(
            action: {
                isPerformingTask = true
            
                Task {
                    await action()
                    isPerformingTask = false
                }
            },
            label: {
                ZStack {
                    // We hide the label by setting its opacity
                    // to zero, since we don't want the button's
                    // size to change while its task is performed:
                    label().opacity(isPerformingTask ? 0 : 1)

                    if isPerformingTask {
                        ProgressView()
                    }
                }
            }
        )
        .disabled(isPerformingTask)
    }
}
