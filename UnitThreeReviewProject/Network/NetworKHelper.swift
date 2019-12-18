//
//  NetworKHelper.swift
//  UnitThreeReviewProject
//
//  Created by Tanya Burke on 12/16/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation

class NetworkHelper {
    
    static let shared = NetworkHelper()
    // 13& 15 makes a singleton, can't make another instance of network helper
    private var session: URLSession
    
    private init() {//initializer for session
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            if let error = error{
                completion(.failure(.networkClientError(error)))
                return
            }
            guard let urlResponse = response as? HTTPURLResponse else{
                completion(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            switch urlResponse.statusCode{
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}
