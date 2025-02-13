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
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
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
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
}
