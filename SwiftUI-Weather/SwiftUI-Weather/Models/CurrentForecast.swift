//
//  CurrentForecast.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

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
    var pressureMB: Double
    var pressureIn: Double
    var humidity: Int
    var cloud: Int
    var feelsLikeC: Double
    var feelsLikeF: Double
    var visibilityKm: Int
    var visibilityMiles: Int
    var uv: Int
    var windGustMph: Double
    var windGustKph: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedInSeconds = "last_updated_epoch"
        case lastUpdatedString = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDirection = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case humidity
        case cloud
        case feelsLikeC = "feelslike_c"
        case feelsLikeF = "feelslike_f"
        case visibilityKm = "vis_km"
        case visibilityMiles = "vis_miles"
        case uv
        case windGustMph = "gust_mph"
        case windGustKph = "gust_kph"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastUpdatedInSeconds = try values.decode(Int.self, forKey: .lastUpdatedInSeconds)
        lastUpdatedString = try values.decode(String.self, forKey: .lastUpdatedString)
        let tempCValue = try values.decode(Double.self, forKey: .tempC)
        tempC = Int(tempCValue)
        let tempFValue = try values.decode(Double.self, forKey: .tempF)
        tempF = Int(tempFValue)
        let isDayValue = try values.decode(Int.self, forKey: .isDay)
        isDay = isDayValue != 0
        condition = try values.decode(Condition.self, forKey: .condition)
        windMph = try values.decode(Double.self, forKey: .windMph)
        windKph = try values.decode(Double.self, forKey: .windKph)
        windDegree = try values.decode(Int.self, forKey: .windDegree)
        windDirection = try values.decode(String.self, forKey: .windDirection)
        pressureMB = try values.decode(Double.self, forKey: .pressureMB)
        pressureIn = try values.decode(Double.self, forKey: .pressureIn)
        humidity = try values.decode(Int.self, forKey: .humidity)
        cloud = try values.decode(Int.self, forKey: .cloud)
        feelsLikeC = try values.decode(Double.self, forKey: .feelsLikeC)
        feelsLikeF = try values.decode(Double.self, forKey: .feelsLikeF)
        visibilityKm = try values.decode(Int.self, forKey: .visibilityKm)
        visibilityMiles = try values.decode(Int.self, forKey: .visibilityMiles)
        uv = try values.decode(Int.self, forKey: .uv)
        windGustMph = try values.decode(Double.self, forKey: .windGustMph)
        windGustKph = try values.decode(Double.self, forKey: .windGustKph)
    }
}
