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
        let title:String
        let id:Int
        let adult:Bool
        let release_date:String
        let poster_path:String

    }
    
}
