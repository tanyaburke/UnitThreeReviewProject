//
//  AppError.swift
//  UnitThreeReviewProject
//
//  Created by Tanya Burke on 12/16/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation


enum AppError: Error {
    
  case badURL(String) // associated value
  case noResponse //no response
  case networkClientError(Error) // no internet connection/ internet response at all/ no internet
  case noData //there is internet, but no data is returned
  case decodingError(Error) //there's data but it can't be decoded because improper JSON fromatting in model or on the api
  case encodingError(Error)
  case badStatusCode(Int) // 404, 500 - maxed out api requests- returned in wrong format- 404 can't access website
  case badMimeType(String) // image/jpg - file extension .jpg- not getting the extension your expecting

    //TODO Handle more descriptive language for error cases
//    var description: String{
//        return  "AppError \(self)"
//    }
    
}
