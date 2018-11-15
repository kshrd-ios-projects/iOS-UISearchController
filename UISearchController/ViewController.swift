//
//  ViewController.swift
//  UISearchController
//
//  Created by Sreng Khorn on 11/15/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    
    // Properties
    var models = [Model]()
    var filteredModels = [Model]()
    let search = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "cellReuseIdentifier"
    
    
    func initSearch() {
//        search.searchBar.scopeButtonTitles = ["Friends", "Everyone"]
//        search.searchBar.delegate = self
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        definesPresentationContext = true
        navigationItem.searchController = search
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        initSearch()
        
        models = [
            Model(movie:"The Dark Night", genre:"Action"),
            Model(movie:"The Avengers", genre:"Action"),
            Model(movie:"Logan", genre:"Action"),
            Model(movie:"Shutter Island", genre:"Thriller"),
            Model(movie:"Inception", genre:"Thriller"),
            Model(movie:"Titanic", genre:"Romance"),
            Model(movie:"La la Land", genre:"Romance"),
            Model(movie:"Gone with the Wind", genre:"Romance"),
            Model(movie:"Godfather", genre:"Drama"),
            Model(movie:"Moonlight", genre:"Drama"),
            Model(movie:"Pekmi CTN", genre:"Comedy"),
            Model(movie:"Neay Kreun", genre:"Comedy")
        ]
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let term = searchController.searchBar.text else {
            return
        }
        filterRowsForSearchedText(term)
    }
    
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        print("Scope Slected => \(selectedScope)")
//    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel")
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        filteredModels = models.filter({( model : Model) -> Bool in
            return model.movie.lowercased().contains(searchText.lowercased())||model.genre.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search.isActive && search.searchBar.text != "" {
            return filteredModels.count
        }
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let model: Model
        if search.isActive && search.searchBar.text != "" {
            model = filteredModels[indexPath.row]
        } else {
            model = models[indexPath.row]
        }
        
        cell.textLabel?.text = model.movie
        cell.detailTextLabel?.textColor = .red
        cell.detailTextLabel?.text = model.genre
        
        return cell
    }
    
    
}
