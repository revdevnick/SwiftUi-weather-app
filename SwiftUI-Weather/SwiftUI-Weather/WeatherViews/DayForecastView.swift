//
//  DayForecastView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/7/23.
//

import SwiftUI

struct DayForecastView: View {
    
    private var day: ForecastDay
    
    init(for day: ForecastDay) {
        self.day = day
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(day.day.maxTempF)°")
                .font(.sfCompactFont(.medium, size: 20))
            Image(systemName: day.day.condition.sfSymbol)
                .resizable()
                .frame(width: 20, height: 20)
            Text(day.monthDay)
                .font(.sfCompactFont(.medium, size: 15))
        }
        .padding(.vertical, 10)
        .frame(width: 70)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2))
    }
}
