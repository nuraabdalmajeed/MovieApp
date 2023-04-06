//
//  NetworkCases.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import Foundation
struct API {
    static let key = "c9856d0cb57c3f14bf75bdc6c063b8f3"
}
enum MovieCases: String {
    case nowPlaying = "movie/now_playing"
    case upcoming = "movie/upcoming"
    case popular = "movie/popular"
    case trending = "discover/movie"
    public var urlString: String {
        let language = Constants.shared.isAR ? "ar":"en-US"
        return "\(MovieDownloadManager.baseURL)\(self.rawValue)?api_key=\(API.key)&language=\(language)"
    }
}
