//
//  API.swift
//  UnitThreeReviewProject
//
//  Created by Tanya Burke on 12/16/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation

struct PodcastAPICLient {
    
    static func fetchPodcast(query: String, completion: @escaping (Result <[Podcast],AppError>)->()){
        let searchTerm = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let podcastEndPointURLString = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchTerm)"
        guard let url = URL(string: podcastEndPointURLString) else {
            completion(.failure(.badURL(podcastEndPointURLString)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request){
            (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let podcasts = try
                        JSONDecoder().decode(Results.self, from: data)
                    completion(.success(podcasts.results))
                }catch{
                    completion(.failure(.decodingError(error)))
                    
                }
                
            }
        }
    }


static func postFavorite(favorite: Podcast, completion: @escaping (Result<Bool, AppError>)->()){
    
    let endpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
    guard let url = URL(string: endpointURLString) else{
        completion(.failure(.badURL(endpointURLString)))
        return
    }
    do {
        let data = try JSONEncoder().encode(favorite)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
         
        NetworkHelper.shared.performDataTask(with: request){(result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success:
                completion(.success(true))
            }
        }
        
    } catch {
        completion(.failure(.encodingError(error)))
    }
}
    
    
    
    static func fetchFavorites(completion: @escaping (Result <[Podcast],AppError>)->()){
         let favpodcastEndPointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
         guard let url = URL(string: favpodcastEndPointURLString) else {
             completion(.failure(.badURL(favpodcastEndPointURLString)))
             return
         }
         let request = URLRequest(url: url)
         
         NetworkHelper.shared.performDataTask(with: request){
             (result) in
             switch result{
             case .failure(let appError):
                 completion(.failure(.networkClientError(appError)))
             case .success(let data):
                 do{
                     let favpodcasts = try
                         JSONDecoder().decode([Podcast].self, from: data)
                    completion(.success(favpodcasts))
                 }catch{
                     completion(.failure(.decodingError(error)))
                     
                 }
                 
             }
         }
     }


}
