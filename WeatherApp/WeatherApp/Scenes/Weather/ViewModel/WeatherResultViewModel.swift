//
//  WeatherResultViewModel.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import Foundation
import CoreLocation

final class WeatherResponseViewModel: NSObject {
    private let locationManager = CLLocationManager()
    var weeklyWeather: WeatherResponseViewModel.WeeklyWeather?
    typealias WeeklyForecast = ((Result<WeatherResponseViewModel.WeeklyWeather, Error>) -> Void)
    var getWeeklyForecasts: WeeklyForecast?
    
    override init() {
        super.init()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func checkLocationStatus(completion: @escaping ((CLAuthorizationStatus) -> Void)) {
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedAlways:
            print("authorized always")
        case .authorizedWhenInUse:
            print("authorized when in use")
        case .denied:
            completion(.denied)
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("restricted")
        default:
            print("")
        }
    }
    
    private func getWeatherInterval(for urlString: String) {
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString )!) { [weak self] (result) in
            switch result {
            case let .success(response):
                self?.prepareViewModel(with: response)
            case let .failure(error):
                print(error.localizedDescription)
                self?.getWeeklyForecasts?(.failure(error))
            }
        }
    }
    
    private func prepareViewModel(with response: WeatherResponse) {
        var daylist: [WeeklyWeather.Day] = []
        
        response.daily?.forEach({ (item) in
            daylist.append(.init(name: getDayFor(timeStamp: item.dt ?? 0),
                                 image: item.weather?.first?.icon ?? "",
                                 maxdegree: getTempFor(temp: item.temp?.max ?? 0),
                                 minDegree: getTempFor(temp: item.temp?.min ?? 0)))
        })
        daylist.removeFirst()
        self.weeklyWeather = .init( currentDay: .init(city: response.timezone ?? "",
                                                      image: response.current?.weather?.first?.icon ?? "",
                                                      degree: getTempFor(temp: response.current?.temp ?? 0)),
                                    days: daylist)
        if let weather = self.weeklyWeather {
            self.getWeeklyForecasts?(.success(weather))
        }
    }
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    private func getDayFor(timeStamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }

    private func getTempFor(temp: Double) -> String {
        let celcius = (temp - 32) / 18 * 10
        return celcius.toString
    }
}

extension WeatherResponseViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coor: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let urlString = API.getURL(lat: coor.latitude, lon: coor.longitude)
        getWeatherInterval(for: urlString)
        locationManager.stopUpdatingLocation()
    }
}

extension WeatherResponseViewModel {
    
    enum Sections: Int, CaseIterable {
        case currentForecast = 0
        case dailyForecast
    }
    
    struct WeeklyWeather {
        let currentDay: CurrentDay?
        let days: [Day]?
        
        struct CurrentDay {
            let city: String
            let image: String
            let degree: String
        }
        
        struct Day {
            let name: String
            let image: String
            let maxdegree: String
            let minDegree: String
        }
    }
}
