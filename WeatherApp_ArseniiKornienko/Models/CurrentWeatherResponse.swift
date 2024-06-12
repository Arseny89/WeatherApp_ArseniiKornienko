//
//  CurrentWeather.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import Foundation

struct CurrentWeather: Codable {
    let name: String
    let timezone: Int
    let country: String
    let coordinates: Coordinates
    let main: WeatherItem
    let weather: [WeatherConditions]
}
