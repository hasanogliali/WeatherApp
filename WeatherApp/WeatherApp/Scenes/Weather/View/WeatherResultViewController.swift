//
//  WeatherResultViewController.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import UIKit

final class WeatherResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: WeatherResponseViewModel?
    typealias Sections = WeatherResponseViewModel.Sections
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeatherResponseViewModel()
        prepareDataSource()
        tableView.registerNib(CurrentWeatherTableViewCell.self, bundle: .main)
        tableView.registerNib(DailyForecastTableViewCell.self, bundle: .main)
    }
    
    func prepareDataSource() {
        viewModel?.checkLocationStatus(completion: { [weak self] status in
            status == .denied ? self?.presentAlert("Ayarlardan konum izni veriniz."): ()
        })
        
        viewModel?.getWeeklyForecasts = { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.presentAlert(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar(animated: animated)
    }
}

extension WeatherResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .currentForecast:
            return 1
        case .dailyForecast:
            return viewModel?.weeklyWeather?.days?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section) {
        case .currentForecast:
            let cell = tableView.dequeueCell(type: CurrentWeatherTableViewCell.self, indexPath: indexPath)
            cell.configureCell(viewModel: self.viewModel?.weeklyWeather?.currentDay)
            return cell
        case .dailyForecast:
            let cell = tableView.dequeueCell(type: DailyForecastTableViewCell.self, indexPath: indexPath)
            cell.configurecell(viewModel: self.viewModel?.weeklyWeather?.days?[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}
