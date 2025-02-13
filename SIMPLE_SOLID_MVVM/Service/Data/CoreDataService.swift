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
    
    func fetchMovie() -> Movie {
        let request :NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do{
            let movieEntity = try context.fetch(request)
            return movieEntity.map{
                Movie.Results(
                    id:Int($0.id),
                    title:$0.title ?? "",
                    adult:Bool($0.adult),
                    releaseDate:$0.release_date ?? "",
                    posterPath:$0.poster_path ?? ""
                )
            }
            .reduce(into: Movie(results: [])){ result, item in
                
            }
            
            
        }catch{
            print("failed fetch movie... : \(error)")
            return Movie(results: [])
        }
    }
}
