//
//  MovieDetails.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View{
    @StateObject private var loader: ImageLoader
    @ObservedObject private var movieManger = MovieDownloadManager()
    var movie: Movie
    init( movie: Movie ) {
        self.movie = movie
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string:movie.concatPosterPath) ?? URL(fileURLWithPath: "")))
        
    }
    
    var body:some View {
        ZStack() {
            backgroundView
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center){
                    headerView
                    moviePosterView
                    movieOverview
                    reviewLink
                    castInfo
                    Spacer()
                }.padding([.top,.bottom], 30)
                    .padding(.horizontal, 32)
            }.frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                    .navigationTitle(movie.titleWithLanguage)
                    .navigationBarTitleDisplayMode(.inline)
                    .clipped() 
        }
    }
    
    private var backgroundView:some View {
        WebImage(url:  URL(string:movie.concatPosterPath)).blur(radius: 90)

    }

    
    private var headerView:some View {
        VStack {
            Text("Release Date:".localized() + " \(movie.releaseDate ?? "")").font(.subheadline)
        }.padding(.top,30).foregroundColor(.white)
    }
    
    private var moviePosterView:some View {
        HStack(alignment: .center) {
            Spacer()
            
            if let url = URL(string:movie.concatPosterPath) {
                WebImage(url:url )
                    .resizable()
              .frame(width: 200, height: 320).cornerRadius(20)
            } else {
                Rectangle().foregroundColor(Color.gray)

            }
            Spacer()
        }
    }
    
    private var movieOverview:some View {
        Text(movie.overview ?? "")
            .font(.body)
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 16)
    }
    
    private var reviewLink:some View {
        VStack {
            Divider()
            NavigationLink(destination: MovieReviewView(movie: movie).transition(.slide.animation(.easeInOut))){
                HStack{
                    Text("Reviews".localized())
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    Text("Show >".localized())
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(color: .blue, radius: 1)
                }
            }
            Divider()
            
        }
        
    }
    private var castInfo:some View {
        VStack(alignment: .leading) {
            Text("Cast".localized()).foregroundColor(.white)
            ScrollView(.horizontal,showsIndicators: false){
                HStack(alignment: .top,spacing:  20) {
                    ForEach(movieManger.cast){ cast in
                        VStack {
                            
                            ZStack{
                                Rectangle().foregroundColor(Color.gray.opacity(0.4))
                                    .frame(width: 100, height: 160)
                                    .cornerRadius(15)
                                WebImage(url: URL(string: cast.concatProfilePath )!)
                                    .resizable()
                                    .frame(width: 100, height: 160)
                                    .animation(.easeInOut, value: 0.5)
                                    .transition(.opacity)
                                    .scaledToFill()
                                    .cornerRadius(15)
                                    .shadow(radius: 15)
                            }
                            
                            Text("\(cast.name ?? "_") as \(cast.character ?? "_")")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 100)
                                .fixedSize(horizontal: false, vertical: true)
                        }.flipped( Constants.shared.isAR ? .horizontal:nil)
                    }
                }
            }.flipsForRightToLeftLayoutDirection(Constants.shared.isAR ? true: false)
        }
        .onAppear{
            movieManger.getCast(movie: movie)
        }
    }
}
