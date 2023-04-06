//
//  MovieDownloadManger.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI

final class MovieDownloadManager: ObservableObject{
    @Published var movies = [Movie]()
    @Published var cast = [Cast]()
    @Published private var _isLoading: Bool = true

    // Tells if all records have been loaded. (Used to hide/show activity spinner)
    var membersListFull = false
       // Tracks last page loaded. Used to load next page (current + 1)
    var currentPage = 0
       // Limit of records per page. (Only if backend supports, it usually does)
    let perPage = 20
    var isLoading: Bool {
            get { return _isLoading}
        }
    static var baseURL = "https://api.themoviedb.org/3/"
    
    func getNowPlaying(page: Int? = nil) {
        self._isLoading = true
        getMovies(movieURL: .nowPlaying, page: page == nil ? currentPage:page)
    }
    
    func getUpcoming(page: Int?  = nil) {
        self._isLoading = true
        getMovies(movieURL: .upcoming, page: page == nil ? currentPage:page)
        
    }
    
    func getPopular(page: Int? = nil ) {
        self._isLoading = true
        getMovies(movieURL: .trending, page: page == nil ? currentPage:page)
        
    }
    
    func  getCast(movie: Movie) {
        self._isLoading = true
        let language = Constants.shared.isAR ? "ar":"en-US"
        let urlString = "\(Self.baseURL)movie/\(movie.id ?? 100)/credits?api_key=\(API.key)&language=\(language)"
        NetworkManger<CastResponse>.fetch(from: urlString) { (result) in
            switch result {
            case .success(let castResponse):
                self.cast = castResponse.cast ?? []
                self._isLoading = false
            case .failure(let error):
                print("error\(error)")
                self._isLoading = false
            }
        }
    }
    
    private func  getMovies(movieURL: MovieCases, page:Int?) {
        NetworkManger<MovieResponse>.fetch(from: movieURL.urlString+"&page=\((page ?? currentPage) + 1)") { (result) in
            switch result {
            case .success(let movieResponse):
                self.currentPage += 1
                if page != nil {
                    if  page != 0{
                        self.movies.append(contentsOf: movieResponse.results ?? [])
                    }else {
                        self.movies.removeAll()
                        self.movies.append(contentsOf: movieResponse.results ?? [])

                    }
                }
                              // If count of data received is less than perPage value then it is last page.
                if self.currentPage < movieResponse.totalPages ?? 0 {
                    self.membersListFull = true
                }
                self._isLoading = false
            case .failure(let error):
                print("error\(error)")
                self._isLoading = false
            }
        }
    }
}
