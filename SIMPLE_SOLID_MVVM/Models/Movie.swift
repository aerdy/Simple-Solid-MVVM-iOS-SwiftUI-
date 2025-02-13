//
//  Movie.swift
//  MVVMPattern
//
//  Created by Arthdi Putra Anna on 03/02/25.
//

import Foundation

struct Movie:Decodable {
    let results : [Results]
    
    struct Results:Decodable,Identifiable{
        let id:Int
        let title:String
        let adult:Bool
        let releaseDate:String
        let posterPath:String

        enum CodingKeys:String,CodingKey{
            case id
            case adult = "adult"
            case title = "title"
            case releaseDate = "release_date"
            case posterPath = "poster_path"
            
        }
    }
    
}
