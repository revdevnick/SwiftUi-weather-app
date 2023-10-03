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
    
    var sfSymbol: String {
        switch self.text.lowercased() {
        case "mist":
            return "cloud.rain.fill"
        case "overcast":
            return "cloud.fill"
        case "partly cloudy":
            return "cloud.sun.fill"
        case "sunny":
            return "sun.max.fill"
        default:
            return "exclamationmark.triangle.fill"
        }
    }
}
