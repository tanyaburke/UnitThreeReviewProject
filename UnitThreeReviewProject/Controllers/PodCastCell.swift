//
//  SearchCell.swift
//  UnitThreeReviewProject
//
//  Created by Tanya Burke on 12/17/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

class PodCastCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var podcastImage: UIImageView!
    
    func configureCell(podcast: Podcast){
        label.text = """
        \(podcast.collectionName)\n\(podcast.artistName)
        
"""
        
       podcastImage.getImage(with: podcast.artworkUrl100) {[weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.sync{
                    self?.podcastImage.image = UIImage(systemName: "exclamationmark.triangle")
                    
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                    
                }
            }
            
        }
    }
    
    }


