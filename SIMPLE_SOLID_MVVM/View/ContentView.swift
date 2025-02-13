//
//  ContentView.swift
//  SIMPLE_SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 12/02/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel:ListMovieViewModel
    
    init(){
        let networkService = NetworkService()
        let coreDataService = CoreDataService(context: PersistenceController.shared.container.viewContext)
        
        _viewModel = StateObject(wrappedValue: ListMovieViewModel(networkService: networkService , coreDataService: coreDataService))
    }
    var body: some View {
        NavigationView {
            Group{
                if viewModel.isLoading {
                    ProgressView("Loading..")
                }else if viewModel.movies.results.isEmpty{
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }else{
                    List(viewModel.movies.results) { movie in
                        VStack(alignment: .leading) {
                            Text(String(movie.title))
                                .font(.headline)
                            
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original"+movie.posterPath)) { image in
                            
                                image.resizable()
                            } placeholder: {
                                Color.red
                            }
                            .frame(width: 100, height: 128)
                            .clipShape(.rect(cornerRadius: 5))
                            Text(String(movie.releaseDate))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            
            .navigationTitle("The Movies")
            .onAppear {
                viewModel.fetchListMovies()
            }
        }
        
    }
}

#Preview {
    let persistenceController = PersistenceController.shared
    
    ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
}
