//
//  ContentView.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var ShowSettings = false
    var body: some View {
        NavigationView{
            Group{
                HomeTabView().toolbarBackground(.gray, for: .navigationBar)
                
            }
            .navigationViewStyle(.stack)
            .navigationBarTitle("Movies", displayMode: .large)
            .bold()
            .navigationBarItems( trailing: HStack{
                setting
            })
            .sheet(isPresented: $ShowSettings, content:{
                    SettingsView(isPresented: $ShowSettings)
                        .environment(\.locale, Locale(identifier: Constants.shared.isAR ? "ar":"en"))
                        .environment(\.layoutDirection, Constants.shared.isAR ? .rightToLeft:.leftToRight)
            })
            
        }.navigationViewStyle(.stack)
        
    }
    private var setting : some View {
        Button(action: {
            ShowSettings.toggle()
        }, label: {
            HStack{
                Image(systemName: "gear")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 30,height:  30)
            }
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
