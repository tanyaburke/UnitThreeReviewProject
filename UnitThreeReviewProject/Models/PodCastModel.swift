//
//  PodCastModel.swift
//  UnitThreeReviewProject
//
//  Created by Tanya Burke on 12/17/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import Foundation

struct Results: Codable{
    var resultCount: Int
    var results:[Podcast]
}

struct Podcast: Codable {
    
 var kind: String?
 var collectionId: Int?
 var trackId: Int
 var artistName:String?
 var collectionName: String
 var trackName: String?
 var trackViewUrl: String?
 var artworkUrl100: String?
 var trackPrice: Int?
 var trackRentalPrice: Int?
 var releaseDate: String?
 var primaryGenreName: String?
var artworkUrl600: String
var genres: [String]?
    var favoritedBy: String?
    
}

