//
//  Extension.swift
//  MovieDB
//
//  Created by Hongfei Zheng on 9/27/21.
//

import UIKit
extension UIImageView {
    func imageFromServerURL(_ URLString: String) {
        let image_url = constant.IMAGE_BASE_URL.rawValue + URLString
        if let url = URL(string: image_url) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }

        }
    }
    
}
