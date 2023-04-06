//
//  Cast.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import Foundation
struct CastResponse: Codable {
    var cast: [Cast]?
}

struct Cast: Codable, Identifiable {
    var id: Int?
    var name: String?
    var character: String?
    var profilePath: String?
    var concatProfilePath: String {
        if let path = profilePath {
            return "https://image.tmdb.org/t/p/original\(path)"
        } else {
            return "https://picsum.photos/200/300"
        }
    }
    enum CodingKeys: String, CodingKey {
        case name
        case id,character
        case profilePath = "profile_path"
        
    }
}
