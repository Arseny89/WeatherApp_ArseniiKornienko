//
//  CurrentWeather.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
    let name: String?
    let id: Int
    let timezone: Int
    let sys: Sys
    let coordinates: Coordinates
    let main: WeatherItem
    let weather: [WeatherConditions]
    enum CodingKeys: String, CodingKey {
        case name
        case timezone
        case coordinates = "coord"
        case main
        case weather
        case sys
        case id
    }
    
    struct Sys: Codable {
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }
}
