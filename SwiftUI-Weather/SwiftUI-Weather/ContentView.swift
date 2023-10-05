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
            //self.oldAppearance()
            self.newAppearance()
        }
        .task {
            do {
                model.forecast = try await model.getForecast(for: "27527")
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
    
    private func newAppearance() -> some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color.sunnyYellow.gradient)
                .ignoresSafeArea()
            VStack {
                Text("Paris")
                    .font(Font.custom("SF-Compact-Display-Bold", size: 26))
                Spacer()
            }
        }
    }
    
    private func oldAppearance() -> some View {
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
                        model.forecast = try await model.getForecast(for: "27527")
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
}

#Preview {
    ContentView()
}


extension Font {
    
    enum SFCompactDisplayFont: String {
        case black = "SF-Compact-Display-Black"
        case bold = "SF-Compact-Display-Bold"
        case heavy = "SF-Compact-Display-Heavy"
        case light = "SF-Compact-Display-Light"
        case medium = "SF-Compact-Display-Medium"
        case regular = "SF-Compact-Display-Regular"
        case semibold = "SF-Compact-Display-Semibold"
        case thin = "SF-Compact-Display-Thin"
        case ultralight = "SF-Compact-Display-Ultralight"
        
    }
    
    static func sfCompactFont(_ type: SFCompactDisplayFont, size: CGFloat = 20) -> Font {
        return .custom(type.rawValue, size: size)
    }
    
}


