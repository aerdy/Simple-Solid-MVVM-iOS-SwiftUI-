//
//  ContentView.swift
//  SIMPLE_SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 12/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ListMovieViewModel(networkService: NetworkService())
    
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
                            
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original"+movie.poster_path)) { image in
                            
                                image.resizable()
                            } placeholder: {
                                Color.red
                            }
                            .frame(width: .infinity, height: 128)
                            .clipShape(.rect(cornerRadius: 5))
                            Text(String(movie.release_date))
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
