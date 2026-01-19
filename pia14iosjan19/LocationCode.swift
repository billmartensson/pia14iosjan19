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
        
        
        
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("LOCATION ERROR")
        print(error.localizedDescription)
    }
    
}
