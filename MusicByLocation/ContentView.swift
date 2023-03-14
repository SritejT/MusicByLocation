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
            Text(state.artistNames)
            
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
