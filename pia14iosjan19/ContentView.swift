//
//  ContentView.swift
//  pia14iosjan19
//
//  Created by BillU on 2026-01-19.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @State var loccode = LocationCode()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
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
