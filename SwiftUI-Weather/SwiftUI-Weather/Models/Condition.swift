//
//  Condition.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

struct Condition: Codable, Equatable, Hashable {
    var text: String
    var icon: String
    var code: Int
    
    /// Codes for WeatherAPI found here https://www.weatherapi.com/docs/weather_conditions.json
    var sfSymbol: String {
        switch self.code {
        case 1195, 1192, 1243, 1246: //heavy rain
            return "cloud.heavyrain.fill"
        case 1072, 1030, 1240, 1198: // drizzle or light rain
            return "cloud.drizzle.fill"
        case 1183, 1186, 1189: //moderate rain
            return "cloud.rain.fill"
        case 1006, 1009:
            return "cloud.fill"
        case 1003:
            return "cloud.sun.fill"
        case 176, 1063:
            return "cloud.sun.rain.fill"
        case 179:
            return "sun.snow.fill"
        case 1000:
            return "sun.max.fill"
        case 1069, 1249, 1264, 1261, 1204, 1207, 1252: //sleet or ice pellets
            return "cloud.sleet.fill"
        case 1087: //thunder
            return "cloud.bolt.fill"
        case 0000: //thunder sun - not valid code, placeholder
            return "cloud.sun.bolt.fill"
        case 0001: //thunder moon - not valid code, placeholder
            return "cloud.moon.bolt.fill"
        case 1276, 1273: //rain and thunder
            return "cloud.bolt.rain.fill"
        case 1114, 1117: //wind snow blowing
            return "wind.snow"
        case 1135, 1147:
            return "cloud.fog.fill"
        case 1255: //light snow
            return "cloud.snow.fill"
        case 1216, 1219: //moderate snow
            return "cloud.snow"
        case 1210, 1279: //light snow showers daytime (possible thunder 1279)
            return "sun.snow.fill"
        case 1282, 1258, 1222, 1225: //heavy snow
            return "snowflake"
        default:
            return "exclamationmark.triangle.fill"
        }
    }
}
