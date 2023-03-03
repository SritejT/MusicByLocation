//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Ravindra Tummuru on 02/03/2023.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocality: String = ""
    @Published var lastKnownThoroughfare: String = ""
    @Published var lastKnownPlaceName: String = ""
    @Published var lastKnownPostalCode: String = ""
    @Published var lastKnownSubLocality: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
        
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.lastKnownLocality = "Could not perform lookup of location from coordinate information."
                    self.lastKnownThoroughfare = "Could not perform lookup of throughfare from coordinate information."
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        self.lastKnownLocality = firstPlacemark.locality ?? "Couldn't find locality."
                        self.lastKnownThoroughfare = firstPlacemark.thoroughfare ?? "Couldn't find thoroughfare."
                        self.lastKnownPlaceName = firstPlacemark.name ?? "Couldn't find place name."
                        self.lastKnownPostalCode = firstPlacemark.postalCode ?? "Couldn't find postal code."
                        self.lastKnownSubLocality = firstPlacemark.subLocality ?? "Couldn't find sub-locality."
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocality = "Error Finding Locality."
    }
}
