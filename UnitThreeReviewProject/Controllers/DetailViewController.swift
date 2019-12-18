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
        detailLabel.text = "\(podcast.collectionName)\n\nArtist Name: \(podcast.artistName ?? "")\nGenre:  \(podcast.primaryGenreName ?? "")\nSubGenre: \(podcast.genres?.joined(separator: ", ") ?? "")\nTrack Name: \(podcast.trackName ?? "")\nPrice: \(podcast.trackPrice ?? 0)\nTrack Rental Price: \(podcast.trackRentalPrice ?? 0)"
        
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

        let vpodcast = Podcast(kind: podcast?.kind, collectionId: nil, trackId: podcast?.trackId ?? 0, artistName: podcast?.artistName ?? "", collectionName: podcast?.collectionName ?? "", trackName: podcast?.trackName ?? "", trackViewUrl: nil, artworkUrl100: podcast?.artworkUrl100 ?? "", trackPrice: podcast?.trackPrice ?? 0, trackRentalPrice: podcast?.trackPrice ?? 0, releaseDate: nil , primaryGenreName: podcast?.primaryGenreName ?? "", artworkUrl600: podcast?.artworkUrl600 ?? "", genres: podcast?.genres ?? ["N/A"], favoritedBy: "Tanya") 
        
        PodcastAPICLient.postFavorite(favorite: vpodcast) { [weak self](result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async{
                    self?.showAlert(title: "Error", message: "Unable to add to favorites\(appError)")
                }
            case .success:
                DispatchQueue.main.async{
                    self?.showAlert(title: "Success", message: "Added to favorites")
                }
            }
        }
    }
    
    }
    
    


