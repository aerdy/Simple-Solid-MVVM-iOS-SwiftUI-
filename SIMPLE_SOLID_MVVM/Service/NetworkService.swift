//
//  NetworkServiceProtocol.swift
//  SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 12/02/25.
//

import Foundation

protocol NetworkServiceProtocol{
    func fetchListMovie(completion: @escaping (Result<MovieData,Error>) -> Void)
}


class NetworkService:NetworkServiceProtocol{
    func fetchListMovie(completion: @escaping (Result<MovieData, any Error>) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "include_adult", value: "false"),
          URLQueryItem(name: "include_video", value: "false"),
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
          URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMzFhNzkyMTA1ZTJhZmNlZWZjNjQ1MDA1ZGM3NTY5ZCIsIm5iZiI6MTQ2MDcyNDc3NC4xNTEsInN1YiI6IjU3MTBlNDI1YzNhMzY4NDEyMjAwM2FhMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lVqxa_XThwrB-obHwVQlmYuY6gYPChWo4v1tPpZdArc"
        ]
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error{
                print("error","error")
                completion(.failure(error))
                return
            }
            
            guard let data = data else{
                print("failure","failure")
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(MovieData.self, from: data)
                print("success","success")
                completion(.success(movies))
            }catch {
                print("failure 2","failure")
                completion(.failure(error))
            }
        }.resume()
    }    
    
}

