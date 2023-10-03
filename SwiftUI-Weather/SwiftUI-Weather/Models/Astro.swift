//
//  Astro.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

struct Astro: Codable, Hashable {
    var sunrise: String
    var sunset: String
    var moonrise: String
    var moonset: String
    var moonPhase: String
    var moonIllumination: String
    var isMoonUp: Bool
    var isSunUp: Bool
    
    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sunrise = try container.decode(String.self, forKey: .sunrise)
        self.sunset = try container.decode(String.self, forKey: .sunset)
        self.moonrise = try container.decode(String.self, forKey: .moonrise)
        self.moonset = try container.decode(String.self, forKey: .moonset)
        self.moonPhase = try container.decode(String.self, forKey: .moonPhase)
        self.moonIllumination = try container.decode(String.self, forKey: .moonIllumination)
        let moonUpValue = try container.decode(Int.self, forKey: .isMoonUp)
        self.isMoonUp = moonUpValue != 0
        let sunUpValue = try container.decode(Int.self, forKey: .isSunUp)
        self.isSunUp = sunUpValue != 0
    }
    
    static func == (lhs: Astro, rhs: Astro) -> Bool {
        return lhs.sunrise == rhs.sunrise &&
        lhs.sunset == rhs.sunset &&
        lhs.moonrise == rhs.moonrise &&
        lhs.moonset == rhs.moonset &&
        lhs.moonPhase == rhs.moonPhase &&
        lhs.moonIllumination == rhs.moonIllumination &&
        lhs.isMoonUp == rhs.isMoonUp &&
        lhs.isSunUp == rhs.isSunUp
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(sunrise)
            hasher.combine(sunset)
            hasher.combine(moonrise)
            hasher.combine(moonset)
            hasher.combine(moonPhase)
            hasher.combine(moonIllumination)
            hasher.combine(isMoonUp)
            hasher.combine(isSunUp)
        }
}
