//
//  ArtistResponse.swift
//  MusicByLocation
//
//  Created by Ravindra Tummuru on 04/03/2023.
//

import Foundation

struct ArtistResponse: Codable {
    var count: Int
    var results: [Artist]
    
    private enum codingKeys: String, CodingKey {
        case count = "resultCount"
        case results
    }
}
