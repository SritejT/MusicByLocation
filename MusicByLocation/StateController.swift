//
//  StateController.swift
//  MusicByLocation
//
//  Created by Ravindra Tummuru on 04/03/2023.
//

import Foundation

class StateController: ObservableObject {
    var lastKnownLocation: String = "" {
        didSet {
            getArtists()
        }
    }
    @Published var artistNames: String = ""
    let locationHandler = LocationHandler()
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func getArtists() {
        var lastKnownLocationURL = ""
        let lastKnownLocationChars = Array(lastKnownLocation)
        for i in 0..<lastKnownLocationChars.count {
            if lastKnownLocationChars[i] == " " {
                lastKnownLocationURL += "%20"
            } else {
                lastKnownLocationURL += String(lastKnownLocationChars[i])
            }
        }

        guard let url = URL(string: "https://itunes.apple.com/search?term=\(lastKnownLocationURL)&entity=musicArtist&limit=5")
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let response = self.parseJson(json: data) {
                    let names = response.results.map {
                        return $0.name
                    }
                    
                    DispatchQueue.main.async {
                        self.artistNames = names.joined(separator: ", ")
                    }
                }
            }
        }.resume()
    }
    
    func parseJson(json: Data) -> ArtistResponse? {
        let decoder = JSONDecoder()
        
        if let artistResponse = try? decoder.decode(ArtistResponse.self, from: json) {
            return artistResponse
        } else {
            print("Error decoding JSON")
            return nil
        }
    }
}
