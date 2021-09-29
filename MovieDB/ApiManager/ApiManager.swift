//
//  ApiManager.swift
//  MovieDB
//
//  Created by Hongfei Zheng on 9/27/21.
//

import UIKit
protocol passData {
    func retrieveData(_ movieList: MovieList)
}
class ApiManager{
    var delegate: passData?
    static let shared = ApiManager()
    func getmoviewListFromServer(url: String){
        let url = URL.init(string: url)!
        let objUrlSession = URLSession.shared
        let jsondecoder = JSONDecoder()
        objUrlSession.dataTask(with: url) {Data, URLResponse, Error in
            if let data = Data{
                let movieList = try! jsondecoder.decode(MovieList.self, from: data)
                self.delegate?.retrieveData(movieList)
            }
        }.resume()
    }
    
    
}
