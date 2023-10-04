//
//  WeatherAPIError.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/4/23.
//

import Foundation

enum WeatherAPIError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case forbidden(String)
}
