//
//  HomeTabView.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI

struct HomeTabView: View {
    enum Tabs: Int {
        case movie
        case discover
    }
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
    }
    @State private var  selectedTab = Tabs.movie
    
    var body: some View {
        ZStack(alignment: .top){
            LinearGradient(colors: [Color(uiColor: .gray),.blue,.gray], startPoint: .topLeading, endPoint: .bottomLeading).blur(radius: 100)
                TabView(selection: $selectedTab){
                MoviesView().tabItem{
                    tabBarItem(title: "Movies".localized(), image: "film")
                }.tag(Tabs.movie)

                DiscoverView().tabItem{
                    tabBarItem(title: "Discover".localized(), image: "square.stack")
                }.tag(Tabs.discover)
                }.accentColor(.white)
                
        }.edgesIgnoringSafeArea(.all)
    }
    private func tabBarItem(title :String, image: String) -> some View{
        VStack {
            Image(systemName: image)
                .tint(.white)
                .imageScale(.large)
            Text(title)
            
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
