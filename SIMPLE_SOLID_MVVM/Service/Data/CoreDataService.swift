//
//  CoreDataService.swift
//  SIMPLE_SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 13/02/25.
//

import CoreData
import SwiftUICore
import SwiftData

class CoreDataService {

    @MainActor
    static let shared = CoreDataService()
    
    private let modelContainer : ModelContainer
    private let context:ModelContext
    

    @MainActor
    private init() {
        let schema = Schema([
                    Movie.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            context = modelContainer.mainContext
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func saveMovie(movie:MovieData){
        do {
            for item in movie.results {
                let movie = Movie(
                    id: item.id,
                    title: item.title,
                    releaseDate: item.releaseDate,
                    posterPath: item.posterPath,
                    adult: item.adult)
                context.insert(movie)
                try context.save()
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    func fetchMovie() -> [MovieData.Results]{
        do{
            let descriptor = FetchDescriptor<Movie>()
            let fetchData = try context.fetch(descriptor)
            return fetchData.map { item in
                return MovieData.Results(
                            id:Int(item.id),
                            title:item.title,
                            adult:Bool(item.adult),
                            releaseDate:item.releaseDate,
                            posterPath:item.posterPath
                        )
                    }
        }catch{
            return []
        }
    }
}

    
    
