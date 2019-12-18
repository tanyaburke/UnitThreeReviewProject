//
//  FavoritesViewController.swift
//  UnitThreeReviewProject
//
//  Created by Tanya Burke on 12/17/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var favorites = [GetFavoritePodcast](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadFavorites()
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else{
            fatalError("can't segue")
        }
        
      //  detailVC.podcast = favorites [indexPath.row])
    }
    
    func loadFavorites(){
        PodcastAPICLient.fetchFavorites { [weak self](result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Error loading Data")
                }
            case .success(let data):
                self?.favorites = data.filter{$0.favoritedBy == "Tanya"}
            }
        }
        
    }
    
   

}

extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
     let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        let favPodcast = favorites[indexPath.row]
        
        cell.imageView?.getImage(with: favPodcast.artworkUrl600, completion: { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async{
                    self.showAlert(title: "Error", message: "NO Image")
                }
            case .success(let image):
                DispatchQueue.main.async{
                cell.imageView?.image = image
            }
            }
        })
        cell.textLabel?.text = favPodcast.collectionName
        cell.detailTextLabel?.text = favPodcast.favoritedBy
        
        return cell
    }
    
    
}
