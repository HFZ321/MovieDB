//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Hongfei Zheng on 9/30/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var popularityLabelView: UILabel!
    @IBOutlet weak var dateLabelView: UILabel!
    var detailTitle: String?
    var detailPopularity: String?
    var detailDate: String?
    var detailPath: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabelView.text = detailTitle
        popularityLabelView.text = detailPopularity
        dateLabelView.text = detailDate
        imageView.imageFromServerURL(detailPath ?? "")
    }
    
    func setInfo(movie: Movie){
        if let title = movie.title, let date = movie.release_date, let popularity = movie.popularity, let path = movie.backdrop_path{
            detailTitle = "Title: \(title)"
            detailPopularity = "Popularity: \(popularity)"
            detailDate = "Date: \(date)"
            detailPath = path
        }
        
    }

}
