//
//  MovieModel.swift
//  MovieDB
//
//  Created by Hongfei Zheng on 9/24/21.
//

import UIKit

struct Movie: Codable {
    var backdrop_path: String?
    var id: Int?
    var original_title: String?
    var popularity: Double?
    var release_date: String?
    var title: String?
    
}

struct MovieList: Codable {
    var results: [Movie] = []
}
