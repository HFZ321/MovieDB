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
    var filterMovie: [Movie] = []
    var isSearch = false
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
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
        if isSearch{
            num = filterMovie.count
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
        
        var movie = objMovieList?.results[indexPath.row]
        if isSearch{
            movie = filterMovie[indexPath.row]
        }
        if let movie = movie{
            cell?.setInfo(movie: movie)
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        if let vc = vc{
            if isSearch{
                vc.setInfo(movie: filterMovie[indexPath.row])
            }else{
                vc.setInfo(movie: objMovieList?.results[indexPath.row] ?? Movie())
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
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
extension TableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearch = true
        if searchText == ""{
            isSearch = false
        }
        filterItem(searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        searchBar.resignFirstResponder()
    }
}

