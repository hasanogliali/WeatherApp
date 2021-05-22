//
//  Double+Extension.swift
//  WeatherApp
//
//  Created by Ali Hasanoğlu on 22.05.2021.
//

import Foundation

extension Double {
    var toString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 1
        let returnString = numberFormatter.string(from: self as NSNumber)
        return "\(returnString ?? "0")°"
    }
}
