//
//  ViewModel.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/3/23.
//

import Foundation

@Observable final class ViewModel {
    
    var isNight: Bool = false
    var animate: Bool = false
    var forecast: Forecast?
    var isUpdating: Bool = false
    
}
