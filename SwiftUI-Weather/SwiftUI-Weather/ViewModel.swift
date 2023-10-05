//
//  ViewModel.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

@Observable final class ViewModel {
    
    var isNight: Bool = false
    var animate: Bool = false
    var forecast: Forecast?
    var isUpdating: Bool = false
    var useMetricSystem: Bool {
        return Locale.current.measurementSystem == .metric
    }
    
    func getForecast(for city: String) async throws -> Forecast {
        let endpoint = "https://weatherapi-com.p.rapidapi.com/forecast.json?q=\(city)&days=3"
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
    
}
