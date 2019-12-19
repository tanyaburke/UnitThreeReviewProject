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
    
    private var urlString = ""
    
    
    func configureCell(podcast: Podcast){
        label.text = """
        \(podcast.collectionName)\n\(podcast.artistName ?? "")
        
"""
        guard let imageURL = podcast.artworkUrl100 else {
            podcastImage.image = UIImage(systemName: "mic.fill")
            return
        }
//        urlString = imageURL
        
        podcastImage.getImage(with: imageURL) {[weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async{//async- right away with no interruptions
                    self?.podcastImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
                    
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                    
                }
            }
            
        }
    }
     override func prepareForReuse() {
            super.prepareForReuse()
            podcastImage.image = UIImage(systemName: "mic.fill")
        }
    
    
    }

