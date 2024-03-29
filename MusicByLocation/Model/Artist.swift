//
//  Artist.swift
//  MusicByLocation
//
//  Created by Ravindra Tummuru on 04/03/2023.
//

import Foundation

struct Artist: Codable {
    var name: String
    var genre: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "artistName"
        case genre = "primaryGenreName"
    }
}
