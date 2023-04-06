//
//  Constants.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import Foundation
class Constants {
    static var shared = Constants()
   
    var isAR: Bool { return (MOLHLanguage.currentAppleLanguage() == "ar") }
    let baseURL =  ""    //develop instance
//    let baseURL =   "" // live
    
//    appStoreId https://apps.apple.com/app/id
    let developerMode = false
    let resetLanguage = "resetLanguage"

 
}
