//
//  Hour.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

struct Hour: Codable, Hashable {
    var timeEpoch: Int
    var time: String
    var tempC: Double
    var tempF: Double
    var isDay: Bool
    var condition: Condition
    var windMph: Double
    var windKph: Double
    var windDegree: Int
    var windDir: String
    var pressureMb: Int
    var pressureIn: Double
    var precipMm: Double
    var precipIn: Double
    var humidity: Int
    var cloud: Int
    var feelsLikeC: Double
    var feelsLikeF: Double
    var windChillC: Double
    var windChillF: Double
    var heatIndexC: Double
    var heatIndexF: Double
    var dewpointC: Double
    var dewpointF: Double
    var willItRain: Bool
    var chanceOfRain: Int
    var willItSnow: Bool
    var chanceofSnow: Int
    var visKm: Int
    var visMiles: Int
    var gustMph: Double
    var gustKph: Double
    var uv: Int
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity
        case cloud
        case feelsLikeC = "feelslike_c"
        case feelsLikeF = "feelslike_f"
        case windChillC = "windchill_c"
        case windChillF = "windchill_f"
        case heatIndexC = "heatindex_c"
        case heatIndexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceofSnow = "chance_of_snow"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timeEpoch = try container.decode(Int.self, forKey: .timeEpoch)
        self.time = try container.decode(String.self, forKey: .time)
        self.tempC = try container.decode(Double.self, forKey: .tempC)
        self.tempF = try container.decode(Double.self, forKey: .tempF)
        let isDayValue = try container.decode(Int.self, forKey: .isDay)
        self.isDay = isDayValue != 0
        self.condition = try container.decode(Condition.self, forKey: .condition)
        self.windMph = try container.decode(Double.self, forKey: .windMph)
        self.windKph = try container.decode(Double.self, forKey: .windKph)
        self.windDegree = try container.decode(Int.self, forKey: .windDegree)
        self.windDir = try container.decode(String.self, forKey: .windDir)
        self.pressureMb = try container.decode(Int.self, forKey: .pressureMb)
        self.pressureIn = try container.decode(Double.self, forKey: .pressureIn)
        self.precipMm = try container.decode(Double.self, forKey: .precipMm)
        self.precipIn = try container.decode(Double.self, forKey: .precipIn)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.cloud = try container.decode(Int.self, forKey: .cloud)
        self.feelsLikeC = try container.decode(Double.self, forKey: .feelsLikeC)
        self.feelsLikeF = try container.decode(Double.self, forKey: .feelsLikeF)
        self.windChillC = try container.decode(Double.self, forKey: .windChillC)
        self.windChillF = try container.decode(Double.self, forKey: .windChillF)
        self.heatIndexC = try container.decode(Double.self, forKey: .heatIndexC)
        self.heatIndexF = try container.decode(Double.self, forKey: .heatIndexF)
        self.dewpointC = try container.decode(Double.self, forKey: .dewpointC)
        self.dewpointF = try container.decode(Double.self, forKey: .dewpointF)
        let willRainValue = try container.decode(Int.self, forKey: .willItRain)
        self.willItRain = willRainValue != 0
        self.chanceOfRain = try container.decode(Int.self, forKey: .chanceOfRain)
        let willSnowValue = try container.decode(Int.self, forKey: .willItSnow)
        self.willItSnow = willSnowValue != 0
        self.chanceofSnow = try container.decode(Int.self, forKey: .chanceofSnow)
        self.visKm = try container.decode(Int.self, forKey: .visKm)
        self.visMiles = try container.decode(Int.self, forKey: .visMiles)
        self.gustMph = try container.decode(Double.self, forKey: .gustMph)
        self.gustKph = try container.decode(Double.self, forKey: .gustKph)
        self.uv = try container.decode(Int.self, forKey: .uv)
    }
    
    static func == (lhs: Hour, rhs: Hour) -> Bool {
            return lhs.timeEpoch == rhs.timeEpoch &&
                lhs.time == rhs.time &&
                lhs.tempC == rhs.tempC &&
                lhs.tempF == rhs.tempF &&
                lhs.isDay == rhs.isDay &&
                lhs.condition == rhs.condition &&
                lhs.windMph == rhs.windMph &&
                lhs.windKph == rhs.windKph &&
                lhs.windDegree == rhs.windDegree &&
                lhs.windDir == rhs.windDir &&
                lhs.pressureMb == rhs.pressureMb &&
                lhs.pressureIn == rhs.pressureIn &&
                lhs.precipMm == rhs.precipMm &&
                lhs.precipIn == rhs.precipIn &&
                lhs.humidity == rhs.humidity &&
                lhs.cloud == rhs.cloud &&
                lhs.feelsLikeC == rhs.feelsLikeC &&
                lhs.feelsLikeF == rhs.feelsLikeF &&
                lhs.windChillC == rhs.windChillC &&
                lhs.windChillF == rhs.windChillF &&
                lhs.heatIndexC == rhs.heatIndexC &&
                lhs.heatIndexF == rhs.heatIndexF &&
                lhs.dewpointC == rhs.dewpointC &&
                lhs.dewpointF == rhs.dewpointF &&
                lhs.willItRain == rhs.willItRain &&
                lhs.chanceOfRain == rhs.chanceOfRain &&
                lhs.willItSnow == rhs.willItSnow &&
                lhs.chanceofSnow == rhs.chanceofSnow &&
                lhs.visKm == rhs.visKm &&
                lhs.visMiles == rhs.visMiles &&
                lhs.gustMph == rhs.gustMph &&
                lhs.gustKph == rhs.gustKph &&
                lhs.uv == rhs.uv
        }
        
        func hash(into hasher: inout Hasher) {
            // Combine the hash values of relevant properties
            hasher.combine(timeEpoch)
            hasher.combine(time)
            hasher.combine(tempC)
            hasher.combine(tempF)
            hasher.combine(isDay)
            hasher.combine(condition)
            hasher.combine(windMph)
            hasher.combine(windKph)
            hasher.combine(windDegree)
            hasher.combine(windDir)
            hasher.combine(pressureMb)
            hasher.combine(pressureIn)
            hasher.combine(precipMm)
            hasher.combine(precipIn)
            hasher.combine(humidity)
            hasher.combine(cloud)
            hasher.combine(feelsLikeC)
            hasher.combine(feelsLikeF)
            hasher.combine(windChillC)
            hasher.combine(windChillF)
            hasher.combine(heatIndexC)
            hasher.combine(heatIndexF)
            hasher.combine(dewpointC)
            hasher.combine(dewpointF)
            hasher.combine(willItRain)
            hasher.combine(chanceOfRain)
            hasher.combine(willItSnow)
            hasher.combine(chanceofSnow)
            hasher.combine(visKm)
            hasher.combine(visMiles)
            hasher.combine(gustMph)
            hasher.combine(gustKph)
            hasher.combine(uv)
        }
}
