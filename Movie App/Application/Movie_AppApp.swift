//
//  Movie_AppApp.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import UIKit
import SwiftUI
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setUpDidFinishLaunch()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
        
    }
    
    func setUpDidFinishLaunch() {
        // Keyboard setup
        IQKeyboardManager.shared.enable = true
        
        languageConfiguration()
        
        self.reset()
    }
    
    func languageConfiguration() {
        let currentDeviceLanguage =   NSLocale.current.language.languageCode?.identifier
        //   print("\(currentDeviceLanguage ?? "en")")
        MOLHLanguage.setDefaultLanguage(currentDeviceLanguage ?? "en") // Defult Language
        MOLH.shared.activate(true)
    }
    
    func reset() {
        let window = UIWindow()
        self.window = window
        let resetLanguage = UserDefaults.standard.object(forKey:Constants.shared.resetLanguage) as? Bool ?? false
        
        if resetLanguage == false  {
            window.rootViewController = UIHostingController(rootView: LaunchView() .environment(\.locale, Locale(identifier: Constants.shared.isAR ? "ar":"en"))
                .environment(\.layoutDirection, Constants.shared.isAR ? .rightToLeft:.leftToRight))

        }else{
            
            window.rootViewController = UIHostingController(rootView: ContentView().environment(\.locale, Locale(identifier: Constants.shared.isAR ? "ar":"en"))
                .environment(\.layoutDirection, Constants.shared.isAR ? .rightToLeft:.leftToRight))
            
            UserDefaults.standard.set(false, forKey:  Constants.shared.resetLanguage)
            
        }
        
        
        window.makeKeyAndVisible()
    }
}



struct Movie_AppApp: App {
    var body: some Scene {
        WindowGroup {
            if Constants.shared.isAR {
                ContentView()
                    .environment(\.locale, Locale(identifier: "ar"))
                    .environment(\.layoutDirection, .rightToLeft)
            }else{
                ContentView()
                    .environment(\.locale, Locale(identifier: "en"))
                    .environment(\.layoutDirection, .leftToRight)
            }
        }
    }
    
}
