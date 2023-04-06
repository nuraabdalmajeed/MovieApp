//
//  LaunchView.swift
//  MovieApp
//
//  Created by noura on 12/02/2023.
//

import SwiftUI

struct LaunchView: View {

    private var idiom : UIUserInterfaceIdiom {UIDevice.current.userInterfaceIdiom }

    var body: some View {
        
        ZStack{
            LinearGradient(colors: [Color(uiColor: .gray),.blue,.gray], startPoint: .topLeading, endPoint: .bottomLeading).blur(radius: 100)
            VStack{
               Image("launchScreen")
                        .resizable()
                    .frame(width: idiom == .pad ? 200: 180, height: idiom == .pad ? 200: 200)
                Text("Movie APP")
                    .font(.system(size:30))
                    .bold()
                    .opacity(0.7)
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    goToContentView()
                }
            }
    }
    private func goToContentView() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        if Constants.shared.isAR {
            window.rootViewController = UIHostingController(rootView: ContentView()
                .environment(\.locale, Locale(identifier: "ar"))
                .environment(\.layoutDirection, .rightToLeft)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0))))
        }else{
            window.rootViewController = UIHostingController(rootView: ContentView()
                .environment(\.locale, Locale(identifier: "en"))
                .environment(\.layoutDirection, .leftToRight)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0))))
        }
        
    }
    
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
        
    }
}
