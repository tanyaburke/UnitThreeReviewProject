//
//  DetailViewController.swift
//  UnitThreeReviewProject
//
//  Created by Tanya Burke on 12/17/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
     
    var podcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadDetails()
        
    }

    
    func loadDetails(){
        guard let podcast = podcast else{
            fatalError("unable to access passed information")
        }
        navigationItem.title = "\(podcast.collectionName)"
        detailLabel.text = "\(podcast.collectionName)\n\nArtist Name: \(podcast.artistName)\nGenre:  \(podcast.primaryGenreName)\nSubGenre: \(podcast.genres.joined(separator: ", "))\nTrack Name: \(podcast.trackName)\nPrice: \(podcast.trackPrice)\nTrack Rental Price: \(podcast.trackRentalPrice)"
        
        podcastImage.getImage(with: podcast.artworkUrl600) {[weak self] (result) in
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
    
    
    @IBAction func favoriteAddButton(_ sender: Any) {
        guard let podcast = podcast else { return <#return value#> }
        let podcast = FavoritePodcast(trackId: , favoritedBy: <#T##String#>, collectionName: <#T##String#>, artworkUrl600: <#T##String#>)
        PodcastAPICLient.postFavorite(favorite: podcast) { [weak self](result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async{
                self.showAlert(title: "Error", message: "Unable to add to favorites\(appError)")
                }
            case .success(true):
                DispatchQueue.main.async{
                    self.showAlert(title: "Success", message: "Added to favorites")
                }
            }
        }
    }
    
    }
    
    


