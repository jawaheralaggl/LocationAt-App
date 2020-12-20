//
//  PlacesViewController + GetLocation.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/20/20.
//

import Foundation
import CoreLocation

extension PlacesViewController {
    
    // Uses CLLocationManager to ask the user for their location
    func getUserLocation(locationManager: CLLocationManager) -> ( lat: Double, long:Double) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.pausesLocationUpdatesAutomatically = false
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            if let currentLocation = locationManager.location {
                print("successfully received current location")
                return (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
            }
        case .denied:
            print("user denied location services")
            locationManager.requestWhenInUseAuthorization()
            break
        case .notDetermined:
            print("user location services not determined")
            locationManager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
        
        // If fail to get current location or denied location tracking, return coordinates for San Francisco
        return (Double(37.773972), Double(-122.431297))
    }
    
    // Method to see what the new state is, If the user allowed us to track their location, get new data(Places)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        default:
            fetchPlaces()
        }
    }
    
}
