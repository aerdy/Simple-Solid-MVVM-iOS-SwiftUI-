//
//  Movie.swift
//  SIMPLE_SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 13/02/25.
//

import SwiftData

@Model
class Movie {
    var id: Int
    var title: String
    var releaseDate: String
    var posterPath: String
    var adult: Bool
    
    init(id: Int, title: String, releaseDate: String, posterPath: String, adult: Bool) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.adult = adult
    }
}
