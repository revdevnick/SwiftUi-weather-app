//
//  ViewModel.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

private let BASE_URL = "https://weatherapi-com.p.rapidapi.com"

@Observable final class ViewModel {
    
    private let client = Client()
    
    var request: URLRequest = {
        let url = URL(string: "\(BASE_URL)/forecast.json")
        let path = Bundle.main.path(forResource: "Keys", ofType: "plist")
        let keys = NSDictionary(contentsOfFile: path!)
        let apiKey: String = keys?["WeatherAPIKey"] as! String
        let headers = [
            "X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: url!)
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 10.0
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }()
    
    private(set) var errorMessage: String = ""
    var animate: Bool = false
    var forecast: Forecast?
    var isUpdating: Bool = false
    
    var cityName: String {
        return forecast?.location.cityName ?? "TEST"
    }
    
    var todayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        dateFormatter.locale = Locale.autoupdatingCurrent
        let date = dateFormatter.date(from: forecast?.current?.lastUpdatedString ?? "") ?? Date()
        return dateFormatter.string(from: date)
    }
    
    var currentCondition: String {
        return forecast?.current?.condition.text.capitalized ?? ""
    }
    
    var currentTemp: String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.locale = Locale.current
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .temperatureWithoutUnit
        let temperature = Measurement(value: Double(forecast?.current?.tempC ?? 0), unit: UnitTemperature.celsius)
        return formatter.string(from: temperature)
    }
    
    var currentWind: String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.locale = Locale.current
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        let wind = Measurement(value: Double(forecast?.current?.windKph ?? 0), unit: UnitSpeed.kilometersPerHour)
        return formatter.string(from: wind)
    }
    
    var currentVisbility: String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.locale = Locale.current
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        let visbility = Measurement(value: Double(forecast?.current?.visibilityKm ?? 0), unit: UnitLength.kilometers)
        return formatter.string(from: visbility)
    }
    
    var currentHumidity: String {
        return (forecast?.current?.humidity.description ?? "") + "%"
    }
    
    var summary: String {
        return """
        Today's weather is \(currentCondition.lowercased()) with a temperature of \(currentTemp). The wind is coming from the \(forecast?.current?.windDirection ?? "") at \(currentWind), and the visbility is \(currentVisbility). Humidity is \(currentHumidity).
        """
    }
    
    func fetchWeather(for city: String) async {
        let city = URLQueryItem(name: "q", value: "\(city)")
        let days = URLQueryItem(name: "days", value: "3")
        self.request.url = self.request.url?.appending(queryItems: [city, days])
        
        do {
            self.forecast = try await client.fetch(type: Forecast.self, with: self.request)
        } catch {
            errorMessage = "\((error as! ApiError).customDescription)"
        }
    }
}
