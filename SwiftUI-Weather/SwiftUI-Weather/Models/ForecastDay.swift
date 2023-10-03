//
//  ForecastDay.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

struct ForecastDay: Codable, Hashable {
    var date: String
    var dayOfWeekFormatted: String
    var dateEpoch: Int
    var day: Day
    var astro: Astro
    var hour: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
        case astro
        case hour
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dayFromString = dateFormatter.date(from: self.date)
        self.dayOfWeekFormatted = dayFromString?.formatted(Date.FormatStyle().weekday(.abbreviated)) ?? "UNK"
        
        self.dateEpoch = try container.decode(Int.self, forKey: .dateEpoch)
        self.day = try container.decode(Day.self, forKey: .day)
        self.astro = try container.decode(Astro.self, forKey: .astro)
        self.hour = try container.decode([Hour].self, forKey: .hour)
    }
    
    static func == (lhs: ForecastDay, rhs: ForecastDay) -> Bool {
        return lhs.date == rhs.date &&
        lhs.dayOfWeekFormatted == rhs.dayOfWeekFormatted &&
        lhs.dateEpoch == rhs.dateEpoch &&
        lhs.day == rhs.day &&
        lhs.astro == rhs.astro &&
        lhs.hour == rhs.hour
    }
    
    func hash(into hasher: inout Hasher) {
        // Combine the hash values of all properties
        hasher.combine(date)
        hasher.combine(dayOfWeekFormatted)
        hasher.combine(dateEpoch)
        hasher.combine(day)
        hasher.combine(astro)
        hasher.combine(hour)
    }
}
