//
//  Forecast.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

struct Forecast: Codable {
    
    enum CodingKeys: String, CodingKey {
        case location
        case current
        case forecast
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.location = try container.decode(Location.self, forKey: .location)
        self.current = try container.decodeIfPresent(CurrentForecast.self, forKey: .current)
        self.forecast = try container.decode(ForecastObject.self, forKey: .forecast)
    }
    
    var location: Location
    var current: CurrentForecast?
    var forecast: ForecastObject
}
