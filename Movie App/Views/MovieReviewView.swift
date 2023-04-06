//
//  MovieReviewView.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct MovieReviewView: View {
    @State var movie: Movie
    @StateObject private var loader: ImageLoader
    @ObservedObject var reviewManger : MovieReviewManger
    
    init(movie:Movie){
        self.movie = movie
        self.reviewManger = MovieReviewManger(movie:movie)
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string:movie.concatPosterPath)!))
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
                
                ZStack() {
                    backgroundView
                    List{
                        ForEach(reviewManger.reviews) { review in
                            VStack {
                                Text(review.author ?? "")
                                    .font(.title)
                                    .shadow(color: .black, radius: 1)
                                    .bold()
                                Text(review.content ?? "")
                                    .font(.body)
                                    .shadow(color: .black, radius: 1)
                                    .lineLimit(nil)
                            }
                            .foregroundColor(.white)
                            .listRowBackground(Color.clear)
                        }.padding([.top,.bottom], 30)
                            .padding(.horizontal, 20)
                    }.listRowBackground(Color.clear)
                        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                        .scrollContentBackground(.hidden)

                        .onAppear {
                            reviewManger.getMovieReview()
                        }
                        .navigationBarTitle("Reviews".localized())
                        .navigationBarTitleDisplayMode(.inline)
                    if reviewManger.isLoading{
                        backgroundView
                        LoadingView()
                    }else if reviewManger.reviewsArray.count == 0 {
                        backgroundView
                        EmptyView()
                    }
                    
                }.frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
            
    
    }
    
    private var backgroundView:some View {
        WebImage(url:  URL(string:movie.concatPosterPath))
            .blur(radius: 90)
    }
    
}
struct EmptyView:View{
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image( uiImage: #imageLiteral(resourceName: "empty"))
                Spacer()
            }
        }
    }
}
