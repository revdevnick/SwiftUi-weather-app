//
//  CurrentCityForecastView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/7/23.
//

import SwiftUI

struct CurrentCityForecastView: View {
    
    var name: String
    var date: String
    var current: String
    var temp: String
    var summary: String
    var wind: String
    var humidity: String
    var visbility: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                Text(name)
                    .font(.sfCompactFont(.bold, size: 26))
                    .padding(.top, 50)
                Text(date)
                    .font(.sfCompactFont(.light, size: 16))
                    .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                    .background(.black)
                    .clipShape(Capsule())
                    .foregroundColor(.sunnyYellow)
                    .padding(.top, 8)
                Text(current)
                    .padding(.top, 10)
                    .font(.sfCompactFont(.medium, size: 20))
                Text(temp)
                    .font(.sfCompactFont(.regular, size: 200))
                    .padding(.top, -35)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, -30)
            VStack(alignment: .leading, spacing: 10) {
                Text("Daily Summary")
                    .font(.sfCompactFont(.bold, size: 20))
                Text(summary)
                    .font(.sfCompactFont(.medium, size: 15))
                    .padding(.bottom, 12)
                    .frame(width: .infinity, height: 84)
                HStack(spacing: 40) {
                    VStack {
                        Image(systemName: "wind")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.sunnyYellow)
                            .padding(.top, 8)
                        Text(wind)
                            .font(.sfCompactFont(.bold, size: 20))
                            .foregroundColor(.sunnyYellow)
                            .padding(EdgeInsets(top: 6, leading: 0, bottom: 1, trailing: 0))
                        Text("Wind")
                            .font(.sfCompactFont(.light, size: 16))
                            .foregroundColor(.sunnyYellow)
                    }
                    .padding(.vertical, 20)
                    VStack {
                        Image(systemName: "drop")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.sunnyYellow)
                            .padding(.top, 8)
                        Text(humidity)
                            .font(.sfCompactFont(.bold, size: 20))
                            .foregroundColor(.sunnyYellow)
                            .padding(EdgeInsets(top: 6, leading: 0, bottom: 1, trailing: 0))
                        Text("Humidity")
                            .font(.sfCompactFont(.light, size: 16))
                            .foregroundColor(.sunnyYellow)
                    }
                    .padding(.vertical, 20)
                    VStack {
                        Image(systemName: "eye")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.sunnyYellow)
                            .padding(.top, 8)
                        Text(visbility)
                            .font(.sfCompactFont(.bold, size: 20))
                            .foregroundColor(.sunnyYellow)
                            .padding(EdgeInsets(top: 6, leading: 0, bottom: 1, trailing: 0))
                        Text("Visbility")
                            .font(.sfCompactFont(.light, size: 16))
                            .foregroundColor(.sunnyYellow)
                    }
                    .padding(.vertical, 20)
                }
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 30)
        }
    }
}
