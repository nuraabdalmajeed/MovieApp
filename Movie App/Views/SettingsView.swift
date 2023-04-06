//
//  SettingsView.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import SwiftUI
struct SettingsView: View {
    @Binding var isPresented :Bool
    
    @State private var selection = 1
    @State private var email = ""
    @State private var Language = ["English","Arabic"]
    @State private var selectLanguage = Constants.shared.isAR ? 2:1
    
    var body: some View {
        NavigationView {
            Form {
                
                Picker(selection: $selectLanguage, label: Text("Language")) {
                    Text("English").tag(1)
                    Text("Arabic").tag(2)
                }
                
                Button(action: {
                    changeLanguage()
                }){
                    Text("Save")
                }
            }.navigationTitle("Settings")
            
        }
    }
    
    private func changeLanguage(){
        if Constants.shared.isAR && selectLanguage == 2 {
            isPresented.toggle()
        } else if Constants.shared.isAR && selectLanguage == 1 {
            isPresented.toggle()
            UserDefaults.standard.set(true, forKey: Constants.shared.resetLanguage)
            
            MOLH.setLanguageTo("en")
            MOLH.reset()
        } else if Constants.shared.isAR == false && selectLanguage == 2 {
            isPresented.toggle()
            UserDefaults.standard.set(true, forKey: Constants.shared.resetLanguage)
            MOLH.setLanguageTo("ar")
            MOLH.reset()
        } else {
            isPresented.toggle()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: Binding<Bool>.constant(false))
    }
}
