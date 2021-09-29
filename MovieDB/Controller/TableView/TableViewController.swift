//
//  ViewController.swift
//  MovieDB
//
//  Created by Hongfei Zheng on 9/24/21.
//

import UIKit

class TableViewController: UIViewController{
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var objMovieList: MovieList?
    let searchController = UISearchController(searchResultsController: nil)
    var filterMovie: [Movie] = []
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isSearching: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        tableView.dataSource = self
        tableView.delegate = self
        let apiManger = ApiManager.shared
        ApiManager.shared.delegate = self
        apiManger.getmoviewListFromServer(url: constant.url.rawValue)
    }
    func filterItem(_ searchText: String){
        let results = objMovieList?.results
        filterMovie = results?.filter({ (movie: Movie) -> Bool in
            return (movie.title ?? "").lowercased().contains(searchText.lowercased())
        }) ?? [Movie]()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension TableViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = objMovieList?.results.count ?? 0
        if isSearching{
            num = filterMovie.count
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
        
        var movie = objMovieList?.results[indexPath.row]
        if isSearching{
            movie = filterMovie[indexPath.row]
        }
        if let movie = movie{
            cell?.setInfo(movie: movie)
        }
        return cell ?? UITableViewCell()
    }
}
extension TableViewController: passData{
    func retrieveData(_ movieList: MovieList) {
        self.objMovieList = movieList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
}
}
extension TableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterItem(searchController.searchBar.text ?? "")
    }
    
    
}

