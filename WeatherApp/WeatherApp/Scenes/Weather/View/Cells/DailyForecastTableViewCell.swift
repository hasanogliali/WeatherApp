//
//  DailyForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDayName: UILabel!
    @IBOutlet weak var ivWeather: UIImageView!
    @IBOutlet weak var labelMaxDegree: UILabel!
    @IBOutlet weak var labelminDegree: UILabel!
    
    func configurecell(viewModel: WeatherResponseViewModel.WeeklyWeather.Day?) {
        labelDayName.text = viewModel?.name
        labelMaxDegree.text = viewModel?.maxdegree
        labelminDegree.text = viewModel?.minDegree
        ivWeather.setImage(with: viewModel?.image ?? "")
    }
}
