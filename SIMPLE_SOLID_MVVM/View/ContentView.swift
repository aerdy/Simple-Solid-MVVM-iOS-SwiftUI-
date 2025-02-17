//
//  ContentView.swift
//  SIMPLE_SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 12/02/25.
//

import SwiftUI
import CoreData
import _SwiftData_SwiftUI

struct ContentView: View {
    @StateObject private var viewModel:ListMovieViewModel
    
    init(){
        _viewModel = StateObject(wrappedValue: ListMovieViewModel(networkService: NetworkService() , coreDataService: .shared))
    }
    var body: some View {
        NavigationView {
            Group{
                if viewModel.isLoading {
                    ProgressView("Loading..")
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
    ContentView()
}
