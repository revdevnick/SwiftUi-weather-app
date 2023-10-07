//
//  DayForecastView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/7/23.
//

import SwiftUI

struct DayForecastView: View {
    
    private var day: ForecastDay
    
    private var temperature: String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.locale = Locale.current
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .temperatureWithoutUnit
        let temperature = Measurement(value: Double(day.day.maxTempC), unit: UnitTemperature.celsius)
        return formatter.string(from: temperature)
    }
    
    init(for day: ForecastDay) {
        self.day = day
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(temperature)
                .font(.sfCompactFont(.medium, size: 20))
                .foregroundColor(Color.sunnyText)
            Image(systemName: day.day.condition.sfSymbol)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.sunnyText)
            Text(day.monthDay)
                .font(.sfCompactFont(.medium, size: 15))
                .foregroundColor(Color.sunnyText)
        }
        .padding(.vertical, 10)
        .frame(width: 70)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.sunnyText, lineWidth: 2))
    }
}
