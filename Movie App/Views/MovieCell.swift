//
//  MovieCell.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCell: View {
    private var idiom : UIUserInterfaceIdiom {UIDevice.current.userInterfaceIdiom }

    var movie : Movie
    var body: some View {
        HStack (alignment: .center, spacing:  15) {
            moviePoster
            VStack(alignment: .leading,spacing: 0) {
                movieTitle
                HStack {
                    movieVote
                    movieReleaseDate
                }
                movieOverView
            }
        }
    }
    
    private var moviePoster: some View {
        ZStack {
            
            Rectangle().foregroundColor(Color.gray.opacity(0.4))
                .frame(width: idiom == .pad ? 200: 150, height: idiom == .pad ? 250: 200)
                .cornerRadius(15)

            WebImage(url:  URL(string: movie.concatPosterPath  )!)
                .resizable()
                .frame(width: idiom == .pad ? 200: 150, height: idiom == .pad ? 250: 200)
                .animation(.easeInOut(duration: 0.5), value: 0.5)
                .transition(.opacity)
                .scaledToFill()
                .cornerRadius(15)
                .shadow(radius: 15)
        }
  
    }
    
    private var movieTitle: some View {
        Text(movie.titleWithLanguage)
            .font(.system(size:15))
            .bold()
            .foregroundColor(.white)
        
    }
    
    private var movieVote: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(movie.concatVoteAverage))
                .stroke(Color.orange,lineWidth: 4)
                .frame(width: 50)
                .rotationEffect(.degrees(Constants.shared.isAR ? 90:-90))
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.orange.opacity(0.2),lineWidth: 4)
                .frame(width: 50)
                .rotationEffect(.degrees(Constants.shared.isAR ? 90:-90))
            Text(String.init(format: "%0.2f", movie.voteAverage ?? 0.0))
                .foregroundColor(.black)
                .font(.subheadline)
        }.frame(height: 80)
    }
    
    private var movieReleaseDate: some View {
        
        Text(movie.releaseDate ?? "")
            .font(.subheadline)
            .foregroundColor(.black)
    }
    
    private var movieOverView: some View {
        Text(movie.overview ?? "")
            .font(.body)
            .foregroundColor(.black)
            .lineLimit(3)
        
    }
}
