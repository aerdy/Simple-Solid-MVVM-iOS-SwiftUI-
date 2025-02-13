//
//  CoreDataService.swift
//  SIMPLE_SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 13/02/25.
//

import CoreData

class CoreDataService {
    private let context : NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveMovie(movie:Movie){
        for item in movie.results {
            let movieEntity = MovieEntity(context: context)
            movieEntity.id = Int32(item.id)
            movieEntity.title = item.title
            movieEntity.release_date = item.releaseDate
            movieEntity.poster_path = item.posterPath
            movieEntity.adult = item.adult
            
        }
        do{
            try context.save()
        }catch{
            print("failed save movie... : \(error)")
        }
    }
    
    func fetchMovie() -> [Movie.Results]{
        let request :NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        do{
            let movieEntity = try context.fetch(request)
            return movieEntity.map { item in
                Movie.Results(
                    id:Int(item.id),
                    title:item.title ?? "",
                    adult:Bool(item.adult),
                    releaseDate:item.release_date ?? "",
                    posterPath:item.poster_path ?? ""
                )
            }
        }catch{
            print("failed fetch movie... : \(error)")
            return Movie(results: []).results
        }
    }
}
