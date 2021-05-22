//
//  PreWeatherViewController.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import UIKit

class PreWeatherViewController: UIViewController {

    @IBOutlet weak var tfApiKey: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigationBar(animated: animated)
    }

    @IBAction func btnGetWeather(_ sender: Any) {
        (tfApiKey.text?.isEmpty ?? true)
            ?
            presentAlert("Lütfen bir API Key giriniz")
            :
            goWeatherResult()
    }
    
    private func goWeatherResult() {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        guard let vc = sb.instantiateViewController(
                withIdentifier: "WeatherResultViewController"
        ) as? WeatherResultViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
