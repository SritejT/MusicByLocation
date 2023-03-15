//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Ravindra Tummuru on 02/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var state = StateController()
    
    var body: some View {
        VStack {
            
            List(state.artistsByLocation, id: \.self) { artist in
                HStack {
                    Text(artist[0])
                    Text(artist[1])
                }
            }
            
            Spacer()
        
            
            Button("Find Artists", action: {
                state.findMusic()
            })
            
            Spacer()
            
        }.onAppear(perform: {
            state.requestAccessToLocationData()
            print("Executed")
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
