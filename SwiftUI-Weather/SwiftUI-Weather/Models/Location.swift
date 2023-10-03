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
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case region
        case country
        case latitude = "lat"
        case longitude = "lon"
        case timezoneId = "tz_id"
        case localTimeSeconds = "localtime_epoch"
        case localTimeString = "localtime"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try values.decode(String.self, forKey: .cityName)
        region = try values.decode(String.self, forKey: .region)
        country = try values.decode(String.self, forKey: .country)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        timezoneId = try values.decode(String.self, forKey: .timezoneId)
        localTimeSeconds = try values.decode(Int.self, forKey: .localTimeSeconds)
        localTimeString = try values.decode(String.self, forKey: .localTimeString)
    }
}
