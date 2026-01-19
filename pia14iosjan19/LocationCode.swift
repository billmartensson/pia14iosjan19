//
//  LocationCode.swift
//  pia14iosjan19
//
//  Created by BillU on 2026-01-19.
//

import Foundation
import CoreLocation

@Observable class LocationCode: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func getposition() {
        
        if manager.authorizationStatus == .notDetermined {
            print("requestWhenInUseAuthorization")
            manager.requestWhenInUseAuthorization()
        }
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            print("requestLocation")
            //manager.startUpdatingLocation()
            manager.requestLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        location = locations.first?.coordinate

        /*
        if locations.first!.horizontalAccuracy < 10.0 {
            location = locations.first?.coordinate
            manager.stopUpdatingLocation()
        }
         */
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("LOCATION ERROR")
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.requestLocation()
        }
        
        if manager.authorizationStatus == .denied {
            print("POS DENIED")
        }
        
    }
    
}
