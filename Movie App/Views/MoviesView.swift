//
//  MoviesView.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI

struct MoviesView: View {
    @State private var searchTerm = ""
    @State private var selectionIndex = 0
    @State private var tabs = ["NowPlaying".localized(),"UpComing".localized(),"Trending".localized()]
    
    @ObservedObject  var  movieArray = MovieDownloadManager()

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectionStyle = .none
        
        UINavigationBar.appearance().backgroundColor = UIColor.clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().largeTitleTextAttributes  = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.black,.blue,.blue,.blue,.black], startPoint: .topLeading, endPoint: .bottomLeading).blur(radius: 200)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading) {
                    Text(tabs[selectionIndex])
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.top)
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.medium)
                        TextField("Search...", text: $searchTerm)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }.padding(.horizontal)
                //MARK: - segmentControl
                VStack(spacing: 0) {
                    Picker("_", selection: $selectionIndex) {
                        ForEach(0..<tabs.count, id: \.self) { index in
                            Text(tabs[index])
                                .font(.title)
                                .bold()
                                .tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .onAppear(){
                            selectionIndex = 0
                        }.onChange(of: selectionIndex) { (_) in
                            if selectionIndex == 0 {
                                movieArray.getNowPlaying(page:0)
                            } else if selectionIndex == 1 {
                                movieArray.getUpcoming(page: 0 )
                            } else if  selectionIndex == 2 {
                                movieArray.getPopular(page:0)
                            }
                        }.padding()
                    List{
                        ForEach(
                            movieArray.movies.filter {
                                searchTerm.isEmpty ? true : $0.title?.lowercased().localizedStandardContains(searchTerm.lowercased()) ?? true}) { movie in
                                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                        MovieCell(movie: movie).transition(.slide.animation(.easeInOut))
                                        
                                    } .onAppear(){
                                        if (movieArray.movies.filter {
                                            searchTerm.isEmpty ? true : $0.title?.lowercased().localizedStandardContains(searchTerm.lowercased()) ?? true}.last == movie){
                                            if  selectionIndex == 0 {
                                                movieArray.getNowPlaying()
                                            } else if  selectionIndex == 1 {
                                                movieArray.getUpcoming()
                                            } else if  selectionIndex == 2 {
                                                movieArray.getPopular()
                                            }
                                        }
                                    }.listRowBackground(Color.clear)
                                }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .onAppear {
                        movieArray.getNowPlaying(page:0)
                    }
                    Spacer()
                }.background(.clear)
                
            }
            if movieArray.isLoading {
                LoadingView()
            }
        }
    }
    
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
struct LoadingView:View{
    var body: some View {
        ZStack{
            LinearGradient(colors: [.black,.blue,.blue,.blue,.black], startPoint: .topLeading, endPoint: .bottomLeading).blur(radius: 200)
                .edgesIgnoringSafeArea(.all)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(3)
            
        }
    }
}
