//
//  LocationManager.swift
//  LocationManager_SwiftUI
//
//  Created by cmStudent on 2021/10/23.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    
    @Published var authorizationStatus: Int = 0
    
    // MARK: - Private Properties
    /// location
    private var locationManager: CLLocationManager!
    
    
    // MARK: - Funcs
    func checkLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("位置情報を許可していない")
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = 1
        checkLocationAuthorization()
    }
    
}
