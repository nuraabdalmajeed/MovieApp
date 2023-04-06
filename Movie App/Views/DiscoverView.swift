//
//  DiscoverView.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DiscoverView: View {
    @State private var offset: CGFloat = 0
    @State private var index = 0
    @State  var showDetails = false
    @ObservedObject private var discoverManaged = MovieDownloadManager()
    private var idiom : UIUserInterfaceIdiom {UIDevice.current.userInterfaceIdiom }
    let spacing: CGFloat = 10
    var body: some View {
        ZStack{
            LinearGradient(colors: [.black,.blue,.blue,.blue,.black], startPoint: .topLeading, endPoint: .bottomLeading).blur(radius: 200)
            TabView {
                ForEach(discoverManaged.movies) { movies in
                    //CardView
                    cardView(movie: movies)
                        .flipped( Constants.shared.isAR ? .horizontal:nil)
                }
                .padding(.all)
                
            }.flipsForRightToLeftLayoutDirection(Constants.shared.isAR ? true: false)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onAppear {
                    discoverManaged.getPopular(page:0)
                }
        }
        
    }
    
    private func cardView(movie:Movie) -> some View {
        ZStack(alignment: .bottom){
            //poster view
            posterView(movie: movie)
            detailsView(movie: movie)
        }
        .shadow(radius: 12.0)
        .cornerRadius(12.0)
    }
    
    private func posterView(movie:Movie) -> some View{
        ZStack{
            Rectangle().foregroundColor(Color.gray.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width * 0.9,height:idiom == .pad ? UIScreen.main.bounds.height * 0.8:UIScreen.main.bounds.height * 0.67,alignment: .center)
                .cornerRadius(20)
            WebImage(url:  URL(string: movie.concatPosterPath  )!)
                .resizable()
                .animation(.easeInOut, value: 0.5)
                .transition(.scale)
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.9,height:idiom == .pad ? UIScreen.main.bounds.height * 0.8:UIScreen.main.bounds.height * 0.67,alignment: .center)
                .cornerRadius(20)
                .shadow(radius: 15)
                .overlay(
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.clear,.clear]), startPoint: .center, endPoint: .bottom))
                        .clipped()
                ).cornerRadius(12.0)
        }   
        
    }
    
    private func detailsView(movie:Movie) -> some View {
        VStack(alignment: .leading){
            Spacer()
            VStack(alignment:Constants.shared.isAR ? .trailing: .leading,spacing: 10){
                Text(movie.titleWithLanguage)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top)
                Text(movie.overview ?? "")
                    .multilineTextAlignment(Constants.shared.isAR ? .trailing: .leading)
                    .font(.system(size:15))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top)
                NavigationLink(destination: MovieDetailsView(movie: movie).transition(.slide.animation(.easeInOut))) {
                    Text("details".localized())
                        .bold()
                        .padding()
                        .foregroundColor(Color.black)
                        .background( Color.orange)
                        .cornerRadius(12)
                    
                }.padding()
            }
            
            .frame(width: UIScreen.main.bounds.width * 0.9,alignment: .bottom)
            .background(Color.white.opacity(0.6))
            .cornerRadius(12)
            .lineLimit(5)
        }
        .padding()
        
        
        
    }
    
}
struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
