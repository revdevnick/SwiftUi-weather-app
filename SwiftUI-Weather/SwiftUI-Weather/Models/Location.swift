//
//  Location.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/22/23.
//

import Foundation


struct Location: Codable {
    var cityName: String
    var region: String
    var country: String
    var latitude: Double
    var longitude: Double
    var timezoneId: String
    var localTimeSeconds: Int
    var localTimeString: String
}

struct Condition: Codable {
    var text: String
    var icon: String
    var code: Int
    
    var sfSymbol: String {
        switch self.text.lowercased() {
        case "overcast":
            return "cloud.fill"
        case "partly cloudy":
            return "cloud.sun.fill"
        case "mist":
            return "cloud.rain.fill"
        default:
            return "exclamationmark.triangle.fill"
        }
    }
}

struct CurrentForecast: Codable {
    var lastUpdatedInSeconds: Int
    var lastUpdatedString: String
    var tempC: Int
    var tempF: Int
    var isDay: Bool
    var condition: Condition
    var windMph: Double
    var windKph: Double
    var windDegree: Int
    var windDirection: String
    var pressureMB: Int
    var pressureIn: Int
    var humidity: Int
    var cloud: Int
    var feelsLikeC: Int
    var feelsLikeF: Int
    var visibilityKm: Int
    var visibilityMiles: Int
    var uv: Int
    var windGustMph: Double
    var windGustKph: Double
}


struct ForecastDay: Codable {
    var date: String
    var dateEpoch: Int
    var day: Day
    var astro: Astro
    var hour: [Hour]
}

struct Day: Codable {
    var maxTempC: Double
    var maxTempF: Double
    var minTempC: Double
    var minTempF: Double
    var avgTempC: Double
    var avgTempF: Double
    var maxWindMph: Double
    var maxWindKph: Double
    var totalPercipMM: Int
    var totalPercipIn: Int
    var totalSnowCm: Int
    var avgVisibilityKm: Double
    var avgVisibilityMiles: Int
    var avgHumidity: Int
    var willItRain: Bool
    var chanceOfRain: Int
    var willItSnow: Bool
    var chanceofSnow: Int
}

struct Astro: Codable {
    var sunrise: String
    var sunset: String
    var moonrise: String
    var moonset: String
    var moonPhase: String
    var moonIllumination: String
    var isMoonUp: Bool
    var isSunUp: Bool
}

struct Hour: Codable {
    var timeEpochSeconds: Int
    var time: String
    var tempC: Double
    var tempF: Double
    var isDay: Bool
    var condition: [Condition]
    var windMph: Double
    var windKph: Double
    var windDegree: Int
    var windDirection: String
    var pressureMB: Int
    var pressureIn: Double
    var precipMM: Int
    var precipIn: Int
    var humidity: Int
    var cloud: Int
    var feelsLikeC: Double
    var feelsLikeF: Double
    var windChillC: Double
    var windChillF: Double
    var heatIndexC: Double
    var heatIndexF: Double
    var dewPointC: Double
    var dewPointF: Double
    var willItRain: Bool
    var chanceOfRain: Int
    var willItSnow: Bool
    var chanceofSnow: Int
    var visibilityKm: Int
    var visibilityMiles: Int
    var windGustMph: Double
    var windGustKph: Double
    var uv: Int
}


struct Forecast: Codable {
    var location: Location
    var currentForecast: CurrentForecast
    var forecast: [ForecastDay]
}
