//
//  WeatherResultViewController.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import UIKit

class WeatherResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar(animated: animated)
    }
}
