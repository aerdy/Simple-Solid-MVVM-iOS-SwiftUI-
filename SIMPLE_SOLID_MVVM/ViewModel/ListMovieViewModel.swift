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
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchListMovies() {
        networkService.fetchListMovie{ [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
}
