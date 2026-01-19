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
    var description: String
}

struct ContentView: View {
    
    @State var loccode = LocationCode()
    
    // MINC:
    // 55.611231421252945, 12.994274371360754
    
    // London:
    // 51.507222,-0.1275
    
    // London
    
    @State var mappos = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), latitudinalMeters: 5000, longitudinalMeters: 5000)
    )
     
    
    // Minc
    /*
    @State var mappos = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.611231421252945, longitude: 12.994274371360754), latitudinalMeters: 5000, longitudinalMeters: 5000)
    )
     */
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141), description: "King lives here"),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076), description: "Is a tower")
    ]
    
    @State var selectedmark : UUID?
    
    var body: some View {
        VStack {
            MapReader { proxy in
                Map(position: $mappos) {
                    ForEach(locations) { location in
                        
                        /*
                         Marker(location.name, coordinate: location.coordinate)
                         */
                        
                        Annotation(location.name, coordinate: location.coordinate) {
                            
                            VStack {
                                Text(location.name)
                                    .font(.headline)
                                    .padding()
                                    .foregroundStyle(.white)
                                
                                if selectedmark == location.id {
                                    Text(location.description)
                                        .font(.headline)
                                        .padding()
                                        .foregroundStyle(.white)
                                }
                                
                            }
                            .background(.blue)
                            .onTapGesture {
                                print("TAP \(location.description)")
                                if selectedmark == location.id {
                                    selectedmark = nil
                                } else {
                                    selectedmark = location.id
                                }
                            }
                        }
                        .annotationTitles(.hidden)
                    }
                    
                    MapCircle(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), radius: 500)
                        .stroke(Color.blue, lineWidth: 2)
                    
                    
                }
                .mapStyle(.imagery)
                .onMapCameraChange { context in
                    print("MAP MOVED")
                    print(context.region.center.latitude)
                }
                .onTapGesture() { tapposition in
                    if let coordinate = proxy.convert(tapposition, from: .local) {
                        print(coordinate)
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                    MapPitchToggle()
                    MapScaleView()
                }
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
