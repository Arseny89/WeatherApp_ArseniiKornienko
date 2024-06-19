//
//  DoubleExtension.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/13/24.
//

import Foundation

extension Double {
    func formattedTemp() -> String {
        let roundedTemp = self.rounded()
        return String(format: "%g", roundedTemp) + "º"
    }
}
