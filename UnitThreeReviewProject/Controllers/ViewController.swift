//
//  ViewController.swift
//  UnitThreeReviewProject
//
//  Created by Tanya Burke on 12/16/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var podcasts = [Podcast](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadPodcast(searchTerm: "swift")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else{
            fatalError("can't segue")
        }
        detailVC.podcast = podcasts[indexPath.row]
        
    }
    
    private func loadPodcast(searchTerm: String){
        PodcastAPICLient.fetchPodcast(query: searchTerm) {[weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async{
                    self?.showAlert(title: "Unable to load Podcasts", message: "\(appError)")}
            case .success(let dataArray):
                self?.podcasts = dataArray
            }
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodCastCell else{
            fatalError("could not access PodCastCell")
        }
        let podcast = podcasts[indexPath.row]
        cell.configureCell(podcast: podcast)
        return cell
    }
    
    
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else{
            DispatchQueue.main.async {
            self.showAlert(title: "Error", message: "Please type in a search term")
            
        }
            return
        }
        loadPodcast(searchTerm: searchQuery)
        
    }
    
    
}
