//
//  Day.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

struct Day: Codable, Hashable, Equatable {
    var maxTempC: Double
    var maxTempF: Int
    var minTempC: Double
    var minTempF: Double
    var avgTempC: Double
    var avgTempF: Double
    var maxWindMph: Double
    var maxWindKph: Double
    var totalPercipMM: Double
    var totalPercipIn: Double
    var totalSnowCm: Double
    var avgVisKm: Double
    var avgVisMiles: Double
    var avgHumidity: Double
    var dailyWillItRain: Bool
    var dailyChanceOfRain: Int
    var dailyWillItSnow: Bool
    var dailyChanceofSnow: Int
    var condition: Condition
    var uv: Double
    
    enum CodingKeys: String, CodingKey {
        case maxTempC = "maxtemp_c"
        case maxTempF = "maxtemp_f"
        case minTempC = "mintemp_c"
        case minTempF = "mintemp_f"
        case avgTempC = "avgtemp_c"
        case avgTempF = "avgtemp_f"
        case maxWindMph = "maxwind_mph"
        case maxWindKph = "maxwind_kph"
        case totalPercipMM = "totalprecip_mm"
        case totalPercipIn = "totalprecip_in"
        case totalSnowCm = "totalsnow_cm"
        case avgVisKm = "avgvis_km"
        case avgVisMiles = "avgvis_miles"
        case avgHumidity = "avghumidity"
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceofSnow = "daily_chance_of_snow"
        case condition
        case uv
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.maxTempC = try container.decode(Double.self, forKey: .maxTempC)
        let maxTempValue = try container.decode(Double.self, forKey: .maxTempF)
        self.maxTempF = Int(maxTempValue)
        self.minTempC = try container.decode(Double.self, forKey: .minTempC)
        self.minTempF = try container.decode(Double.self, forKey: .minTempF)
        self.avgTempC = try container.decode(Double.self, forKey: .avgTempC)
        self.avgTempF = try container.decode(Double.self, forKey: .avgTempF)
        self.maxWindMph = try container.decode(Double.self, forKey: .maxWindMph)
        self.maxWindKph = try container.decode(Double.self, forKey: .maxWindKph)
        self.totalPercipMM = try container.decode(Double.self, forKey: .totalPercipMM)
        self.totalPercipIn = try container.decode(Double.self, forKey: .totalPercipIn)
        self.totalSnowCm = try container.decode(Double.self, forKey: .totalSnowCm)
        self.avgVisKm = try container.decode(Double.self, forKey: .avgVisKm)
        self.avgVisMiles = try container.decode(Double.self, forKey: .avgVisMiles)
        self.avgHumidity = try container.decode(Double.self, forKey: .avgHumidity)
        let dailyRainValue = try container.decode(Int.self, forKey: .dailyWillItRain)
        self.dailyWillItRain = dailyRainValue != 0
        self.dailyChanceOfRain = try container.decode(Int.self, forKey: .dailyChanceOfRain)
        let dailySnowValue = try container.decode(Int.self, forKey: .dailyWillItSnow)
        self.dailyWillItSnow = dailySnowValue != 0
        self.dailyChanceofSnow = try container.decode(Int.self, forKey: .dailyChanceofSnow)
        self.condition = try container.decode(Condition.self, forKey: .condition)
        self.uv = try container.decode(Double.self, forKey: .uv)
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(maxTempC)
            hasher.combine(maxTempF)
            hasher.combine(minTempC)
            hasher.combine(minTempF)
            hasher.combine(avgTempC)
            hasher.combine(avgTempF)
            hasher.combine(maxWindMph)
            hasher.combine(maxWindKph)
            hasher.combine(totalPercipMM)
            hasher.combine(totalPercipIn)
            hasher.combine(totalSnowCm)
            hasher.combine(avgVisKm)
            hasher.combine(avgVisMiles)
            hasher.combine(avgHumidity)
            hasher.combine(dailyWillItRain)
            hasher.combine(dailyChanceOfRain)
            hasher.combine(dailyWillItSnow)
            hasher.combine(dailyChanceofSnow)
            hasher.combine(condition)
            hasher.combine(uv)
        }
}
