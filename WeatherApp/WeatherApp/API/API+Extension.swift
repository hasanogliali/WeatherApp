//
//  API+Extension.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import Foundation

extension API {
    static let baseURLString = "https://openweathermap.org/data/2.5/"
    
    static func getURL(lat: Double, lon: Double) -> String {
        return "\(baseURLString)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(apiKey)&units=imperial"
    }
}
