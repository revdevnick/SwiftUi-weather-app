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
                VStack(alignment: .leading) {
                    VStack(alignment: .center) {
                        Text("Paris")
                            .font(.sfCompactFont(.bold, size: 26))
                            .padding(.top, 50)
                        Text("Friday, January 20")
                            .font(.sfCompactFont(.light, size: 16))
                            .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                            .background(.black)
                            .clipShape(Capsule())
                            .foregroundColor(.sunnyYellow)
                            .padding(.top, 8)
                        Text("Sunny")
                            .padding(.top, 10)
                            .font(.sfCompactFont(.medium, size: 20))
                        Text("31°")
                            .font(.sfCompactFont(.regular, size: 200))
                            .padding(.top, -35)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, -30)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Daily Summary")
                            .font(.sfCompactFont(.bold, size: 20))
                        Text("""
        Today's weather is partly cloudy with a temperature of 75°. The wind is coming from the northeast at 10mph, and the visbility is 10 miles. Humidity is 40%.
        """)
                        .font(.sfCompactFont(.medium, size: 15))
                        .frame(width: .infinity, height: 72)
                        .padding(.bottom, 12)
                        HStack(spacing: 40) {
                            VStack {
                                Image(systemName: "wind")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.sunnyYellow)
                                    .padding(.top, 8)
                                Text("4 mph")
                                    .font(.sfCompactFont(.bold, size: 20))
                                    .foregroundColor(.sunnyYellow)
                                    .padding(EdgeInsets(top: 6, leading: 0, bottom: 1, trailing: 0))
                                Text("Wind")
                                    .font(.sfCompactFont(.light, size: 16))
                                    .foregroundColor(.sunnyYellow)
                            }
                            .padding(.vertical, 20)
                            VStack {
                                Image(systemName: "drop")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.sunnyYellow)
                                    .padding(.top, 8)
                                Text("48%")
                                    .font(.sfCompactFont(.bold, size: 20))
                                    .foregroundColor(.sunnyYellow)
                                    .padding(EdgeInsets(top: 6, leading: 0, bottom: 1, trailing: 0))
                                Text("Humidity")
                                    .font(.sfCompactFont(.light, size: 16))
                                    .foregroundColor(.sunnyYellow)
                            }
                            .padding(.vertical, 20)
                            VStack {
                                Image(systemName: "eye")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.sunnyYellow)
                                    .padding(.top, 8)
                                Text("10.1 mi")
                                    .font(.sfCompactFont(.bold, size: 20))
                                    .foregroundColor(.sunnyYellow)
                                    .padding(EdgeInsets(top: 6, leading: 0, bottom: 1, trailing: 0))
                                Text("Visbility")
                                    .font(.sfCompactFont(.light, size: 16))
                                    .foregroundColor(.sunnyYellow)
                            }
                            .padding(.vertical, 20)
                        }
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal, 30)
                    VStack(alignment: .leading) {
                        Text("3-Day Forecast")
                            .font(.sfCompactFont(.bold, size: 20))
                            .padding(.bottom, 5)
                        HStack(spacing: 20) {
                            VStack(spacing: 8) {
                                Text("119°")
                                    .font(.sfCompactFont(.medium, size: 20))
                                Image(systemName: "sun.max.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Jan 20")
                                    .font(.sfCompactFont(.medium, size: 15))
                            }
                            .padding(.vertical, 10)
                            .frame(width: 70)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2))
                            VStack(spacing: 8) {
                                Text("119°")
                                    .font(.sfCompactFont(.medium, size: 20))
                                Image(systemName: "sun.max.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Jan 20")
                                    .font(.sfCompactFont(.medium, size: 15))
                            }
                            .padding(.vertical, 10)
                            .frame(width: 70)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2))
                            VStack(spacing: 8) {
                                Text("119°")
                                    .font(.sfCompactFont(.medium, size: 20))
                                Image(systemName: "sun.max.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Jan 20")
                                    .font(.sfCompactFont(.medium, size: 15))
                            }
                            .padding(.vertical, 10)
                            .frame(width: 70)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2))
                            VStack(spacing: 8) {
                                Text("--°")
                                    .font(.sfCompactFont(.medium, size: 20))
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Jan 21")
                                    .font(.sfCompactFont(.medium, size: 15))
                            }
                            .padding(.vertical, 10)
                            .frame(width: 70)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2))
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 30, trailing: 30))
                    
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
        case black = "SFCompactDisplay-Black"
        case bold = "SFCompactDisplay-Bold"
        case heavy = "SFCompactDisplay-Heavy"
        case light = "SFCompactDisplay-Light"
        case medium = "SFCompactDisplay-Medium"
        case regular = "SFCompactDisplay-Regular"
        case semibold = "SFCompactDisplay-Semibold"
        case thin = "SFCompactDisplay-Thin"
        case ultralight = "SFCompactDisplay-Ultralight"
    }
    
    static func sfCompactFont(_ type: SFCompactDisplayFont = .regular, size: CGFloat = 20) -> Font {
        return .custom(type.rawValue, size: size)
    }
    
}


