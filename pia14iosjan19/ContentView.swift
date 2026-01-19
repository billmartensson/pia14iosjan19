//
//  ContentView.swift
//  pia14iosjan19
//
//  Created by BillU on 2026-01-19.
//

import SwiftUI
import CoreLocation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    
    @State var loccode = LocationCode()
        
    @State var mappos = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), latitudinalMeters: 5000, longitudinalMeters: 5000)
    )
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    
    var body: some View {
        VStack {
            
            Map(position: $mappos) {
                ForEach(locations) { location in
                    Marker(location.name, coordinate: location.coordinate)
                }
            }
            .mapStyle(.imagery)
            .onMapCameraChange { context in
                print("MAP MOVED")
                print(context.region.center.latitude)
            }
            
            
            Button("Get location") {
                loccode.getposition()
            }
            
            if loccode.location != nil {
                Text("\(loccode.location!.latitude)")
                Text("\(loccode.location!.longitude)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
