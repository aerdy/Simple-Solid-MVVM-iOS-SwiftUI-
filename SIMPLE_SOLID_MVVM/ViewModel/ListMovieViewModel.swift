//
//  UserViewModel.swift
//  SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 12/02/25.
//

import Foundation

class ListMovieViewModel: ObservableObject {
    @Published var movies: Movie = Movie(results: [])
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    private let networkService: NetworkServiceProtocol
    private let coreDataService: CoreDataService
    
    init(networkService: NetworkServiceProtocol,coreDataService: CoreDataService) {
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
    
    func fetchListMovies() {
        isLoading = true
        errorMessage = ""
        
        networkService.fetchListMovie{ [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(let movies):
                    self?.movies = movies
                    self?.coreDataService.saveMovie(movie: movies)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.movies = self?.coreDataService.fetchMovie() ?? Movie(results: [])
                }
            }
            
        }
    }
}
