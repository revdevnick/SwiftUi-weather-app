//
//  FutureForecastView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/7/23.
//

import SwiftUI

struct FutureForecastView: View {
    
    var days: [ForecastDay]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("3-Day Forecast")
                .font(.sfCompactFont(.bold, size: 20))
                .padding(.bottom, 5)
                .foregroundColor(Color.sunnyText)
            HStack(spacing: 20) {
                ForEach(days, id: \.self) { day in
                    DayForecastView(for: day)
                }
                Button(action: {
                    print("do something")
                }, label: {
                    VStack(spacing: 8) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.sunnyText)
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: 70, maxHeight: .infinity)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.sunnyText, lineWidth: 2))
                })
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 30, trailing: 30))
    }
}
