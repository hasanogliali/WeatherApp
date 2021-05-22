//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String = "Oops!", _ message: String, buttonTitle: String = "Tamam") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func hideNavigationBar(animated: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
