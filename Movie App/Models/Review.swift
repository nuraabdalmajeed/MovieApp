//
//  Review.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import Foundation

struct ReviewResponse: Codable {
    var results: [Review]?
}
struct Review: Codable ,Identifiable {
    var id: String?
    var author: String?
    var content: String?
}
