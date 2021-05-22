//
//  UIImageView+Extension.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func setImage(with iconCode: String) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: iconCode)) {
            self.image = cachedImage
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        self.addSubview(activityIndicator)
        
        if let url = URL(string: API.getImageURL(with: iconCode)) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let err = error {
                    DispatchQueue.main.async {
                        activityIndicator.stopAnimating()
                    }
                    return
                        print(err.localizedDescription)
                }
                DispatchQueue.main.async { [weak self] in
                    guard let responseData = data,
                          let image = UIImage(data: responseData) else {
                        activityIndicator.stopAnimating()
                        return
                    }
                    
                    imageCache.setObject(image, forKey: NSString(string: iconCode))
                    activityIndicator.stopAnimating()
                    self?.image = image
                }
            }).resume()
        }
    }
}
