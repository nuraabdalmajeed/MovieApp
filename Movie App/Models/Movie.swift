//
//  Movie.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    var dates: Dates?
    var page: Int?
    var results: [Movie]?
    var totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    var maximum, minimum: String?
}

// MARK: - Movie
struct Movie: Codable, Identifiable ,Equatable{
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var concatPosterPath: String {
        if let path = posterPath {
            return "https://image.tmdb.org/t/p/original/\(path)"
        } else {
            return ""
        }
    }
    
    var concatVoteAverage: Double {
        if let average  = voteAverage {
            return average  / 10
        } else {
            return 0.0
        }
    }
    
    var titleWithLanguage: String{
        guard let title = title , let lang = originalLanguage else{return ""}
        return "\(title) \(lang)"
    }
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

