//
//  ForecastObject.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

struct ForecastObject: Codable {
    var forecastDay: [ForecastDay]?
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.forecastDay = try container.decodeIfPresent([ForecastDay].self, forKey: .forecastDay)
    }
}
