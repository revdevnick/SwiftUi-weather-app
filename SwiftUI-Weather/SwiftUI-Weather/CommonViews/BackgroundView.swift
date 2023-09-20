//
//  BackgroundView.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 9/20/23.
//

import SwiftUI

struct BackgroundView: View {
    
    var isNight: Bool
    
    var body: some View {
        //        LinearGradient(colors: [isNight ? .black : .blue, isNight ? .gray : .lightBlue],
        //                       startPoint: .topLeading,
        //                       endPoint: .bottomTrailing)
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
    }
}
