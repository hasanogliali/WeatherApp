//
//  CurrentWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var ivForecasts: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    
    func configureCell(viewModel: WeatherResponseViewModel.WeeklyWeather.CurrentDay?) {
        labelCity.text = viewModel?.city
        labelTemperature.text = viewModel?.degree
        ivForecasts.setImage(with: viewModel?.image ?? "")
    }
}
