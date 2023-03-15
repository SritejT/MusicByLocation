//
//  StateController.swift
//  MusicByLocation
//
//  Created by Ravindra Tummuru on 04/03/2023.
//

import Foundation

class StateController: ObservableObject {
    
    let locationHandler = LocationHandler()
    let iTunesAdaptor = ITunesAdaptor()
    @Published var artistsByLocation: [[String]] = []
    
    var lastKnownLocation: String = "" {
        didSet {
            iTunesAdaptor.getArtists(search: lastKnownLocation, completion: updateArtistNames)
                
        }
    }


    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func updateArtistNames(artists: [Artist]?) {
        let details = artists?.map {
            return [$0.name, $0.genre]
        }
        
        DispatchQueue.main.async {
            self.artistsByLocation = details ?? [["Error finding artist name", "Error finding artist genre"]]
        }
    }
}
