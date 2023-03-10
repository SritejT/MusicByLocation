//
//  Artist.swift
//  MusicByLocation
//
//  Created by Ravindra Tummuru on 04/03/2023.
//

import Foundation

struct Artist: Codable {
    var name: String
    
    private enum codingKeys: String, CodingKey {
        case name = "artistName"
    }
}
