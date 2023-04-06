//
//  MovieReviewManger.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI

final class MovieReviewManger: ObservableObject{
    @Published var reviews = [Review]()
    @Published private var _isLoading = true
    private var movie: Movie
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    
    init( movie: Movie) {
        self.movie = movie
    }
    var isLoading: Bool {
            get { return _isLoading}
        }
    var reviewsArray : [Review] {
            get { return reviews}
        }
    func getMovieReview() {
        _isLoading = true
        getReview(for: movie)

    }
    
    private func  getReview(for movie: Movie) {
        let language = Constants.shared.isAR ? "ar":"en-US"
        let urlString = "\(Self.baseURL)\(movie.id ?? 100)/reviews?api_key=\(API.key)&language=\(language)"

        NetworkManger<ReviewResponse>.fetch(from: urlString) { (result) in
            switch result {
            case .success(let reviewResponse):
                self.reviews = reviewResponse.results ?? []
                self._isLoading = false
            case .failure(let error):
                print("error\(error)")
                self._isLoading = false
            }
        }
    }
}
