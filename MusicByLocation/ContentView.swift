//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Ravindra Tummuru on 02/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        VStack {
            Text("""
                 Place name: \(locationHandler.lastKnownPlaceName)
                 Thoroughfare: \(locationHandler.lastKnownThoroughfare)
                 Sub-Locality: \(locationHandler.lastKnownSubLocality)
                 Locality: \(locationHandler.lastKnownLocality)
                 Postal Code: \(locationHandler.lastKnownPostalCode)
                 """)
                .padding()
            
            Spacer()
            
            Button("Find Music", action: {
                locationHandler.requestLocation()
            })
            
            Spacer()
            
        }.onAppear(perform: {
            locationHandler.requestAuthorisation()
            
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
