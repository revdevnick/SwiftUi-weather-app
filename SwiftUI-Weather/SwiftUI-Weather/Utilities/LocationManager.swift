//
//  LocationManager.swift
//  SwiftUI-Weather
//
//  Created by Nick Perkins on 10/7/23.
//

import CoreLocation

@Observable
final class LocationManager {
    private let locationManager = CLLocationManager()
    
    var location: CLLocation? = nil
    
    func requestUserAuthorization() async throws {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startCurrentLocationUpdates() async throws {
        for try await locationUpdate in CLLocationUpdate.liveUpdates() {
            guard let location = locationUpdate.location, location != self.location else { return }
            self.location = location
        }
    }
}
