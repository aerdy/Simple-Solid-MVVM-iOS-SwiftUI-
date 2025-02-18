//
//  NetworkServiceProtocol.swift
//  SOLID_MVVM
//
//  Created by Arthdi Putra Anna on 12/02/25.
//

import Foundation
import Alamofire
protocol NetworkServiceProtocol{
    func fetchListMovie(completion: @escaping (Result<MovieData,Error>) -> Void)
}


class NetworkService:NetworkServiceProtocol{
    func fetchListMovie(completion: @escaping (Result<MovieData, any Error>) -> Void) {
        
        let url = "https://api.themoviedb.org/3/discover/movie"
        let parameters: [String: Any] = [
            "include_adult": "false",
            "include_video": "false",
            "language": "en-US",
            "page": "1",
            "sort_by": "popularity.desc"
        ]
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMzFhNzkyMTA1ZTJhZmNlZWZjNjQ1MDA1ZGM3NTY5ZCIsIm5iZiI6MTQ2MDcyNDc3NC4xNTEsInN1YiI6IjU3MTBlNDI1YzNhMzY4NDEyMjAwM2FhMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lVqxa_XThwrB-obHwVQlmYuY6gYPChWo4v1tPpZdArc"
        ]
        let utilityQueue = DispatchQueue.global(qos: .utility)

        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: MovieData.self,queue: utilityQueue) { response in
            switch response.result {
            case .success(let value):
                print("Response: \(value)")
                if response.data != nil {
                    completion(.success(value))
                }
                
            case .failure(let error):
                print("failure 2",error.localizedDescription)
                completion(.failure(error))
            }
        }
       
    }    
    
}

